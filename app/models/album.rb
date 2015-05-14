class Album < ActiveRecord::Base
  validates :title, :recording_type, :band_id, presence: true
  validates :recording_type, inclusion: {
    in: %w(live studio),
    message: 'must be "live" or "studio"' }

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
