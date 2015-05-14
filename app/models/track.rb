class Track < ActiveRecord::Base
  validates :title, :is_bonus, :album_id, presence: true

  belongs_to :album
  has_one :band, through: :album, source: :band
end
