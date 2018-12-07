class SearchController < ApplicationController
  def index
    @songs = Song.where("title LIKE ?", "%#{params[:search]}%")
    @albums = Album.where("title LIKE ?", "%#{params[:search]}%")
    @artists = Artist.where("name LIKE ?", "%#{params[:search]}%")
    puts @songs
    puts @albums
    puts @artists
  end
 
  def new
  end
end
