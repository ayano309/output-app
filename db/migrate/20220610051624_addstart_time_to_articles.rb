class AddstartTimeToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :start_time, :datetime
  end
end
