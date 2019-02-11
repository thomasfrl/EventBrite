class User < ApplicationRecord
  has_many :attendances
  has_many :administrated_events, class_name: "Event", foreign_key: "administrator_id"
  has_many :events, through: :attendances

  validates :first_name, presence: true
  validates :last_name, presence: true

end
