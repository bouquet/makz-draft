class Video
  include Ripple::Document

  property :title, String
  property :video_token, String
  property :sub_on, Boolean, :default => false
  timestamps!

  validates_presence_of :title
  validates_presence_of :video_token

  many :artists

  before_create :short_key

  def thumbnail
    "thumbnails/#{self.key}.jpg"
  end

private

  def short_key
    self.key = rand(36**8).to_s(36)
  end
end
