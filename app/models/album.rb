class Album < ActiveRecord::Base
  validate :title, :recording_type, :band_id, presence: true

  belongs_to :band
  has_many :tracks
end
