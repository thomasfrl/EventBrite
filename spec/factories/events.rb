FactoryBot.define do
  factory :event do
      duration { 100 }
      start_date { Time.now + 3600}
      title { "un super evenement"}
      description { "on s'amuse tellement tous ensemble ouiiiiiiiiiiiii"}
      price { 10}
      location { "Paris"}
      administrator_id { FactoryBot.create(:user).id}
  end
end
