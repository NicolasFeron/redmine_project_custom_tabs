module TabSettingHelper
	def display_model_name tab_setting
		tab_setting.tab_setting_model.nil?? (tab_setting.query.nil? ? "" : l(:default_tab_settings_model)) : tab_setting.tab_setting_model.name
	end	

	def display_query_name tab_setting
		tab_setting.query.nil? ? "" : tab_setting.query.name
	end	
end	
