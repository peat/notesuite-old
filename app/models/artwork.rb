class Artwork < ActiveRecord::Base
  
  validates_presence_of :basename, :source_file
  attr_accessor :source_file
  after_destroy :delete_archive
      
  TRANSFORMS = {
    :original => '>2048x2048',
    :large => ">1024x1024",
    :default => ">500x500",
    :thumbnail => ">150x150",
  }
  
  TRANSFORM_DIR = RAILS_ROOT + '/tmp/images/'
    
  def filename( transform = :default )
    raise "Invalid Transformation: #{transform}" unless TRANSFORMS.keys.include?(transform)
    "#{self.basename}_#{transform}.#{self.extension}"
  end
  
  def extension
    'jpg'
  end
  
  def local_file( transform = :default )
    TRANSFORM_DIR + self.filename( transform )
  end
  
  def url( transform = :default )
    "http://#{S3_BUCKET}.s3.amazonaws.com/#{self.filename( transform )}"
  end
  
  def do_transformations
    FileUtils.mkdir_p( TRANSFORM_DIR ) # just in case
    TRANSFORMS.each do |name, geometry|
      if name == :original
        FileUtils.cp source_file.path, self.local_file( name )
      else
        system CONVERT_PATH, source_file.path, "-resize", geometry, "-depth", "8", "-strip", self.local_file( name )
      end
    end
  end

  # push the artwork to S3
  def archive
    TRANSFORMS.keys.each do |transform|
      ::AWS::S3::S3Object.store( self.filename( transform ), open( self.local_file( transform ) ), Artwork.bucket.name, :access => :public_read )
    end
  end
  
  def delete_archive
    TRANSFORMS.keys.each do |transform|
      ::AWS::S3::S3Object.delete( self.filename( transform ), Artwork.bucket.name )
    end
  end
  
  def self.bucket
    ::AWS::S3::Bucket.find( S3_BUCKET )
  end
    
  def transform_and_archive
    do_transformations and archive unless source_file.blank?
  end
  
end
