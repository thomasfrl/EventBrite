class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :stripe_customer_id, presence: true

  after_create :event_send
  after_create :admin_send

  def event_send
    EventMailer.event_email(self).deliver_now
  end

  def admin_send
    EventMailer.admin_email(self).deliver_now
  end

end
