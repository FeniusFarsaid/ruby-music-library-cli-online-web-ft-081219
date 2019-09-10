require 'pry'
class MusicImporter
  
  attr_reader :path

  def initialize(path)
    @path = path
  end
  
  def files
    @files = Dir.entries(@path).select {|x| x.end_with?(".mp3")}
  end
  
  def import 
    files.each do |name|
      Song.create_from_filename(name)
    end 
  end 
  
end 