class Event < ApplicationRecord
  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :administrator, class_name: "User"

  validates :start_date, presence: true, numericality: {greater_than: Time.now}
  validates :duration, presence: true, numericality: {greater_than: Time.now}
  validates :title, presence: true, lenght: {in: 5..140}
  validates :description, presence: true, lenght: {in: 20..1000}
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 1}, numericality: {less_than_or_equal_to: 1000}
  validates :location, presence: true


end
