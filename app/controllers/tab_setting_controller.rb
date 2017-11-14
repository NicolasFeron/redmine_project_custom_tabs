class TabSettingController < ApplicationController
  helper :queries
  include QueriesHelper
  helper :sort
  include SortHelper
  helper :issues
  include IssuesHelper

    def save
        tab_setting = selected_tab_setting
        if tab_setting.nil?
            tab_setting = TabSetting.new
        end
        unless admin_mode
            tab_setting.project_id = params[:project_id]
        end
        tab_setting.assign_attributes(post_params)
        tab_setting.save!
        flash[:notice] = l(:notice_successful_update)
        unless admin_mode
            redirect_to  action: :index, project_id: tab_setting.project 
        else
            redirect_to  action: :index
        end
    end

    def index
        @tab_settings = TabSetting.all
        unless admin_mode
            redirect_to settings_project_path(get_project(params[:project_id]), :tab => 'custom_tabss')
        end
    end

    def delete        
        tab_setting = selected_tab_setting
        tab_setting.delete    
        Redmine::MenuManager.map(:project_menu).delete(tab_setting.tab_name.to_sym)
        flash[:notice] = l(:notice_successful_delete)
        redirect_to :back
    end

    def new 
        get_project(params[:project_id])
        get_queries(params[:project_id])
        @tab_setting = TabSetting.new
        render :action => 'edit'
    end

    def new_admin
        @projets = Project.active
        @queries = Query.all
        @tab_setting = TabSetting.new
        render :action => 'edit_admin'
    end

    def edit
        @tab_setting = selected_tab_setting
        unless @tab_setting.query.nil?
            @tab_setting.tab_url = nil
        end
        get_project(@tab_setting.project_id)
        get_queries(@tab_setting.project_id)
    end

    def edit_admin
        @projets = Project.active
        @tab_setting = selected_tab_setting
        get_queries(@tab_setting.project_id)
    end

    def default
        @project = Project.find_by_identifier(params[:project_id]) 
        @tab_setting = selected_tab_setting
        @query = Query.find(@tab_setting.query)
        @limit = per_page_option        
        sort_init(@query.sort_criteria.empty? ? [['id', 'desc']] : @query.sort_criteria)
        sort_update(@query.sortable_columns)
        @query.sort_criteria = sort_criteria.to_a
        @issue_count = @query.issue_count
        @issue_pages = Paginator.new @issue_count, @limit, params['page']
        @offset ||= @issue_pages.offset
        @issues = @query.issues(:include => [:assigned_to, :tracker, :priority, :category, :fixed_version],
          :order => sort_clause,
          :offset => @offset,
          :limit =>  @limit)
    end

    def queries
        render json: get_queries(params[:project_id])
    end

    def post_params
        params.require(:tab_setting).permit!
    end

    def selected_tab_setting
        TabSetting.find_by_id(params[:id])
    end

    def admin_mode
        params[:project_id].nil?
    end

    def get_project id        
        @project = Project.find(id)
    end

    def get_queries project_id
        @queries = [Query.new(name:"")] + IssueQuery.where(project_id: project_id)
    end

end