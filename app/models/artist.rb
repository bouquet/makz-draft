class Artist
  include Ripple::Document

  property :name, String
  property :slug, String
  property :country, String
  property :sex, String
  property :birth, Date
  property :videos_added_at, Time
  key_on :slug
  timestamps!

  many :videos

  validates_presence_of :name
  validates_presence_of :sex

  before_save :save_slug

  def video_ids
    self.videos.map {|v| v.key}
  end

  def thumbnail
    "portraits/#{self.slug}.jpg"
  end

  def has_new?
    if self.videos_added_at && Time.now - self.videos_added_at < 3.days
      true
    else
      false
    end
  end

private

  def save_slug
    self.slug = self.name.tr(' ' , '_').downcase
  end
end
