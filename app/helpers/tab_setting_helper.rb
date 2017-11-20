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
		round(times_entries(project,begin_date,end_date).sum(:hours)).to_s
	end

	def times_entries(project,begin_date,end_date)
		project.time_entries.where(spent_on: begin_date..end_date)
	end 

	def projects_and_times_entries(project, begin_date, end_date)
		project_or_children_project(project).each do |p|
			time_entry = time_entries_by_project(p,begin_date, end_date)
			if time_entry.to_i > 0
				yield p, time_entry
			end
		end
	end

	def display_times_entries_group_by_users_group(project,begin_date,end_date)
		result = ""
		project_groups(project).collect  do |group| 
			time_entry = time_entries_by_group(project,group,begin_date, end_date)
			if time_entry.to_i > 0
				content_tag :tr do 
					concat(content_tag :td, group.name, :class=> "one_tab left_align")
					concat(content_tag :td, time_entry, :class=> "left_align")
				end
			end
		end.join.html_safe
	end

	def round value, digit=2
		unless value.nil? && value.blank? 
			value = value.round(digit)
		end
		value
	end


end	
