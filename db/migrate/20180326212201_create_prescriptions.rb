class CreatePrescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :prescriptions do |t|
      t.string :name
      t.integer :rxcui
      t.integer :patient_id
      t.integer :doctor_id
    end
  end
end
