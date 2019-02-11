FactoryBot.define do
  factory :attendance do
   user_id { FactoryBot.create(:user)}
   event_id { FactoryBot.create(:event)}
   stripe_customer_id { "hgdjkd4d56d656d5"}
  end
end
