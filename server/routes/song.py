import uuid
from fastapi import APIRouter, File, UploadFile, Form, Depends
from sqlalchemy.orm import Session
from database import get_db
from middleware.auth_middleware import auth_middleware
import cloudinary
import cloudinary.uploader

from models.song import Song

router = APIRouter()

cloudinary.config( 
    cloud_name = "dczgjykd5", 
    api_key = "189892526545972", 
    api_secret = "1zPmDq6ssdjgzfU3iYlrwQyRBvo", # Click 'View Credentials' below to copy your API secret
    secure=True
)

@router.post('/upload', status_code=201)
def upload_song(song: UploadFile = File(...), thumbnail: UploadFile = File(...), song_name: str = Form(...), artist: str = Form(...), hexcode: str = Form(...), db: Session = Depends(get_db), auth_dict = Depends(auth_middleware)):
    song_id = str(uuid.uuid4())
    song_res = cloudinary.uploader.upload(song.file, resource_type='auto', folder=f'songs/{song_id}')
    thumbnail_res = cloudinary.uploader.upload(thumbnail.file, resource_type='image', folder=f'songs/{song_id}')
    new_song = Song(id=song_id, song_url=song_res['url'], thumbnail_url=thumbnail_res['url'], song_name=song_name, artist=artist, hexcode=hexcode)
    
    db.add(new_song)
    db.commit()
    db.refresh(new_song)
    
    return new_song