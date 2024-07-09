import uuid
import bcrypt
from fastapi import Depends, HTTPException, APIRouter
from fastapi.params import Header
import jwt
from database import get_db
from middleware.auth_middleware import auth_middleware
from models.user import User
from pydantic_schemas.user_create import UserCreate
from sqlalchemy.orm import Session

from pydantic_schemas.user_login import UserLogin


router = APIRouter()

@router.post('/signup', status_code=201)
def signup(user: UserCreate, db: Session=Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    
    if user_db:
        raise HTTPException(status_code=400, detail='User with same email already exists')
    
    hashed_password = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
    user_db = User(id=str(uuid.uuid4()), name=user.name, email=user.email, password=hashed_password)
    
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    return user_db

@router.post('/login')
def login(user: UserLogin, db: Session=Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    
    if not user_db:
        raise HTTPException(status_code=400, detail='User not found')
    
    if not bcrypt.checkpw(user.password.encode(), user_db.password):
        raise HTTPException(status_code=400, detail='Invalid password')
    
    token = jwt.encode({'id': user_db.id}, 'secret')
    
    return {'token': token, 'user': user_db}

@router.get('/')
def get_user(db: Session=Depends(get_db), user_dict=Depends(auth_middleware)):
    user = db.query(User).filter(User.id == user_dict['uid']).first()
    
    if not user:
        raise HTTPException(status_code=404, detail='User not found')
    
    return user
