from sqlalchemy import TEXT, VARCHAR, Column
from models.base import Base

class Song(Base):
    __tablename__ = 'songs'
    
    id = Column(TEXT, primary_key=True) 
    song_url = Column(TEXT)
    thumbnail_url = Column(TEXT)
    song_name = Column(VARCHAR(100))
    hexcode = Column(VARCHAR(6))    
