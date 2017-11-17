module TabSettingHelper
	def display_model_name tab_setting
		tab_setting.tab_setting_model.nil?? (tab_setting.query.nil? ? "" : l(:default_tab_settings_model)) : tab_setting.tab_setting_model.name
	end	

	def display_query_name tab_setting
		tab_setting.query.nil? ? "" : tab_setting.query.name
	end

	def project_groups project
		Group.joins(:members).where("members.project_id=#{project.id}")
	end

	def project_or_children_project(project)
		projects = [project]
		unless project.children.empty?
			projects = project.children
		end
		projects
	end

	def time_entries_by_group(project,group,begin_date,end_date)
		round(times_entries(project,begin_date,end_date).where("user_id in (#{group.users.map(&:id).join(',')})").sum(:hours)).to_s
	end

	def time_entries_by_project(project,begin_date,end_date)
		puts times_entries(project,begin_date,end_date).sum(:hours)
		round(times_entries(project,begin_date,end_date).sum(:hours)).to_s
	end

	def times_entries(project,begin_date,end_date)
		project.time_entries.where(spent_on: begin_date..end_date)
	end 

	def round value, digit=2
		unless value.nil? && value.blank? 
			value = value.round(digit)
		end
		value
	end


end	
