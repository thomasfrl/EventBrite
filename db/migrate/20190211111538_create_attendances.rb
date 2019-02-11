class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.string :stripe_customer_id
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
    end
  end
end
