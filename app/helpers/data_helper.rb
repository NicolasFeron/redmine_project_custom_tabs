module DataHelper
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
end