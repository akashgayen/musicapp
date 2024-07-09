from fastapi import HTTPException, Header
import jwt


def auth_middleware(auth_token=Header()):
    try:
        if not auth_token:
            raise HTTPException(status_code=401, detail='Unauthorized access!')
        
        verified_token = jwt.decode(auth_token, 'secret', algorithms=['HS256'])
        
        if not verified_token:
            raise HTTPException(status_code=401, detail='Unauthorized access!')
        
        uid = verified_token.get('id')
        return {'uid': uid, 'token': auth_token}    
    except jwt.PyJWTError:
        raise HTTPException(status_code=401, detail='Unauthorized access!')