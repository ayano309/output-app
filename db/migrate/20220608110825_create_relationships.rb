class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :following, null: false, foregin_key: { to_table: :users }
      t.references :follower, null: false, foregin_key: { to_table: :users }
      t.timestamps
    end
  end
end
