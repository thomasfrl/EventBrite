class Event < ApplicationRecord
  def multiple_of_5?
    duration % 5 == 0 ? true : errors.add(:duration, "should be a multiple of 5") 
  end

  def not_in_the_past?
    errors.add(:start_date, "cannot be in past") unless 
      start_date.to_i > Time.now.to_i       
  end

  def state
    self.validated == true ? "Validé" : "En attente de vaildation"
  end

  has_one_attached :event_image
  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances
  belongs_to :administrator, class_name: "User"

  
  validates :duration, if: :multiple_of_5?, presence: true, numericality: {greater_than: 0}
  validates :start_date, if: :not_in_the_past?, presence: true
  validates :title, presence: true, length: {in: 5..140}
  validates :description, presence: true, length: {in: 20..1000}
  validates :price, presence: true, numericality: {greater_than: 0, less_than: 1001}
  validates :location, presence: true

end
