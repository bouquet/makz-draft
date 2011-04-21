class Artist
  include Ripple::Document

  property :name, String
  property :slug, String
  property :country, String
  property :sex, String
  property :birth, Date
  key_on :slug

  many :videos

  validates_presence_of :name
  validates_presence_of :sex

  before_save :save_slug

  def video_ids
    self.videos.map {|v| v.key}
  end

  def thumbnail
    "#{self.slug}.jpg"
  end

private

  def save_slug
    self.slug = self.name.tr(' ' , '_')
  end
end
