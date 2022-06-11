class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :introduction
      t.integer :owner_id
      t.timestamps
    end
  end
end
