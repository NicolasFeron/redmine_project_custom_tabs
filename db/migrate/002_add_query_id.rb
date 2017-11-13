class AddQueryId < ActiveRecord::Migration
  def self.up
    add_column :tab_settings, :query_id, :integer
  end

  def self.down
    remove_column :tab_settings, :query_id
  end
end
