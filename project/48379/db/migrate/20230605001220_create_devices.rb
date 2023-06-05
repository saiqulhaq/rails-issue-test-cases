class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :identifier
      t.string :push_token

      t.timestamps
    end

    add_index :devices, [:identifier, :push_token], unique: true
  end
end
