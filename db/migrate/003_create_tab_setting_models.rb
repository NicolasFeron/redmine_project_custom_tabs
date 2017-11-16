class CreateTabSettingModels < ActiveRecord::Migration
   def self.up
    create_table :tab_setting_models do |t|
      t.string :name
      t.string :content
    end    
    add_column :tab_settings, :tab_setting_model_id, :integer
  end
  def self.down
    drop_table :tab_setting_models
    remove_column :tab_setting_models, :tab_setting_model_id
  end
end