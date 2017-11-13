class TabSetting < ActiveRecord::Base
	belongs_to :project  
	belongs_to :query
end