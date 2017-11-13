class CreateTabSettings < ActiveRecord::Migration
   def self.up
    create_table :tab_settings do |t|
      t.integer :project_id
      t.string :tab_name
      t.string :tab_url
    end
  end
end