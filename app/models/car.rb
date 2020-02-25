class Car < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reviews,dependent: :destroy
  belongs_to :user
  validates :model, presence: true
  validates :brand, presence: true
  validates :kind, presence: true
  validates :price, presence: true
  validates :description, presence: true

  include PgSearch
  pg_search_scope :search, against: [:brand, :model], using: {tsearch: {prefix: true, any_word: true}}

  def show
    "#{self.kind.capitalize} #{self.model}. #{self.brand}. Owner: #{self.user.username}"
  end
end
