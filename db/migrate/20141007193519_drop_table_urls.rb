class DropTableUrls < ActiveRecord::Migration
  def change
    drop_table :urls
  end
end
