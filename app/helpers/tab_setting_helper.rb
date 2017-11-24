module TabSettingHelper
	
	################################
	###          Data            ###
	################################
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

	################################
	###          Display         ###
	################################

	def display_model_name tab_setting
		tab_setting.tab_setting_model.nil?? (tab_setting.query.nil? ? "" : l(:default_tab_settings_model)) : tab_setting.tab_setting_model.name
	end	

	def display_query_name tab_setting
		tab_setting.query.nil? ? "" : tab_setting.query.name
	end

	def display_expand_button
		content_tag(:span,"&nbsp;".html_safe, :class=> "expander", :onclick => "toggleRowGroup(this);")
	end

	def options_for_period_select(value)
		options_for_select([[l(:label_this_month), 'current_month'],
							[l(:label_last_month), 'last_month']],
							value.blank? ? 'current_month' : value)
	end

	def display_period_select
		form_tag("/projects/#{@project.identifier}/issues/default/#{@tab_setting.id}", method: "get") do 
			select_tag 'period', options_for_period_select(@period), :onchange => 'this.form.submit();' 
		end 
	end

	def display_export_csv_link(form)
		form.link_to('CSV',:onclick => "exportCSV();return false;")
	end

	################################
	###       Calculation        ###
	################################

	def time_entries_by_group(project,group,begin_date,end_date)
		round(times_entries(project,begin_date,end_date).where("user_id in (#{group.users.map(&:id).join(',')})").sum(:hours)).to_s
	end

	def time_entries_by_project(project,begin_date,end_date)
		round(times_entries(project,begin_date,end_date).sum(:hours)).to_s
	end

	def round value, digit=2
		unless value.nil? && value.blank? 
			value = value.round(digit)
		end
		value
	end

	def issues_count_per_month(issues,month)
		issues.select{|i| i.created_on.month.eql?(month)}.count
	end
end	
