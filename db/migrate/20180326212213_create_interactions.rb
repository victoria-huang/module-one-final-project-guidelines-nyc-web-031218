class CreateInteractions < ActiveRecord::Migration[5.1]
  def change
    create_table :interactions do |t|
      t.integer :med1_id
      t.integer :med2_id
    end
  end
end
