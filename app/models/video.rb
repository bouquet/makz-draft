class Video
  include Ripple::Document

  property :title, String
  property :video_token, String
  property :sub_on, Boolean, :default => false
  property :thumb, String
  property :auto_thumb, Boolean, :default => true
  timestamps!

  validates_presence_of :title
  validates_presence_of :video_token

  many :artists
  many :subtitles

  before_create :short_key
  before_save :default_thumb

private

  def short_key
    self.key = rand(36**8).to_s(36)
  end

  def default_thumb
    self.thumb = "/static/images/thumbnails/#{self.key}.jpg" unless self.auto_thumb
  end
end
