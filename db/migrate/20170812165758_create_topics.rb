class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.attachment :image
      t.references :user, index: true
      t.references :forum, index: true

      t.timestamps
    end
  end
end
