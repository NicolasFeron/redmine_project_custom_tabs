class TabSetting < ActiveRecord::Base
	belongs_to :project  
	belongs_to :query
	belongs_to :tab_setting_model
end