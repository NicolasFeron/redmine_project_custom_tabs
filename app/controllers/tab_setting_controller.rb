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
        else 
            Redmine::MenuManager.map(:project_menu).delete(tab_setting.tab_name.to_sym)
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
            redirect_to settings_project_path(get_project(params[:project_id]), :tab => 'custom_tabs')
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
        get_models
        render :action => 'edit'
    end

    def new_admin
        @tab_setting = TabSetting.new
        @projets = [Project.new(name:"")] + Project.active
        @queries = []
        @tab_setting = TabSetting.new
        get_models
        unless params[:project_id].blank?
            @tab_setting.project_id = params[:project_id]
            get_queries(params[:project_id])
        end
        render :action => 'edit_admin'
    end

    def edit
        @tab_setting = selected_tab_setting
        unless @tab_setting.query.nil?
            @tab_setting.tab_url = nil
        end
        get_project(@tab_setting.project_id)
        get_queries(@tab_setting.project_id)
        get_models
    end

    def edit_admin
        @projets = Project.active
        @tab_setting = selected_tab_setting        
        unless params[:project_id].blank?
            @tab_setting.project_id = params[:project_id]
        end
        get_queries(@tab_setting.project_id)
        get_models
    end

    def default
        load_custom_tab_data
        if !@tab_setting.tab_setting_model.nil? && !@tab_setting.tab_setting_model.content.nil?            
            render :action => :custom, :period => params[:period]
        end
    end

    def custom_model_html
        load_custom_tab_data
        render inline: @tab_setting.tab_setting_model.content
    end

    def load_custom_tab_data
        @period = params[:period]
        @project = Project.find_by_identifier(params[:project_id]) 
        @tab_setting = selected_tab_setting
        @query = Query.find(@tab_setting.query_id)
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
        @queries = [Query.new(name:"")] + IssueQuery.visible.where(project_id: project_id)
    end

    def get_models
        @models = [TabSettingModel.new(name: l(:default_tab_settings_model))] + TabSettingModel.all
    end
end