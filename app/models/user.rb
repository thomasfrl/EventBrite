class User < ApplicationRecord
  has_many :attendances
  has_many :administrated_events, class_name: "Event", foreign_key: "administrator_id", dependent: :destroy
  has_many :events, through: :attendances
  
  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  
  def name 
    self.first_name + " " + self.last_name
  end
end
