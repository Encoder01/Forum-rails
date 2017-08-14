class CreateForums < ActiveRecord::Migration[5.1]
  def change
    create_table :forums do |t|
      t.string :name
    end
    add_index :forums, :name, unique: true
  end
end
