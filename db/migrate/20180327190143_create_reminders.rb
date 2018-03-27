class CreateReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :reminders do |t|
      t.string :note
      t.integer :patient_id
    end 
  end
end
