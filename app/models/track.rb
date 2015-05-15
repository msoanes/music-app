class Track < ActiveRecord::Base
  validates :title, :is_bonus, :album_id, presence: true
  validates :is_bonus, inclusion: { in: %w(T F) }

  belongs_to :album
  has_many :notes
  has_one :band, through: :album, source: :band

  def full_title
    suffix = bonus? ? " (bonus)" : ''
    "#{title}#{suffix}"
  end

  def bonus?
    is_bonus == 'T'
  end
end
