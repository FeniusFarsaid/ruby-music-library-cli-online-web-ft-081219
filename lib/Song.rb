require 'pry'

class Song 
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    
    self.artist= artist if artist!=nil
    self.genre= genre if genre!=nil
  end 
  
  def artist= (artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre= (genre)
    @genre = genre
    if !(genre.songs.include?(self))
      genre.songs << self
    end
  end
  
  def self.all
    @@all
  end 
  
  def save
    @@all << self 
  end 
  
  def self.destroy_all
    @@all.clear
  end 
  
  def self.create(name)
    song = self.new(name)
     song.save
    song
  end
  
  def self.find_by_name(name)
    @@all.detect{|x| x.name == name}
  end 
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end 
  
  def self.new_from_filename(name)
    split_name = name.gsub(".mp3", "").split(" - ")
    artist = Artist.find_or_create_by_name(split_name[0])
    genre = Genre.find_or_create_by_name(split_name[2])
    self.new(split_name[1], artist, genre)
  end 
  
  def self.create_from_filename(name)
    song = self.new_from_filename(name)
    song.save
  end 
  
  

end 