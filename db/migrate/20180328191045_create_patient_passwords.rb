class CreatePatientPasswords < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :password_digest, :string
  end
end
