class AddAdministratorRefToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :administrator, index: true
  end
end
