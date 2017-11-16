# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
	get '/tab_setting/index', :to => 'tab_setting#index', as: 'tab_settings' 
	get '/tab_setting/default', :to => 'tab_setting#default', as: 'default_tab_settings' 
    get '/tab_setting/new_admin', :controller => 'tab_setting', :action => 'new_admin', :as => 'new_admin_tab_setting'
    get '/tab_setting/new/:project_id', :controller => 'tab_setting', :action => 'new', :as => 'new_tab_setting'
    get '/tab_setting/:id/edit_admin', :controller => 'tab_setting', :action => 'edit_admin', :as => 'edit_admin_tab_setting'
    get '/tab_setting/:id/edit', :controller => 'tab_setting', :action => 'edit', :as => 'edit_tab_setting'
    post '/tab_setting/save', :to => 'tab_setting#save'
    delete  '/tab_setting/:id', :controller => 'tab_setting', :action => 'delete', :as => 'delete_tab_setting'
    get '/projects/:project_id/issues/default/:id', :to => 'tab_setting#default', :as => 'default'
	get '/tab_setting/queries', :to => 'tab_setting#queries', as: 'queries_tab_setting' 


	get '/tab_setting_model/index', :to => 'tab_setting_model#index', as: 'tab_setting_models' 
    get '/tab_setting_model/new', :controller => 'tab_setting_model', :action => 'new', :as => 'new_tab_setting_model'
    get '/tab_setting_model/:id/edit', :controller => 'tab_setting_model', :action => 'edit', :as => 'edit_tab_setting_model'
    post '/tab_setting_model/save', :to => 'tab_setting_model#save'
    delete  '/tab_setting_model/:id', :controller => 'tab_setting_model', :action => 'delete', :as => 'delete_tab_setting_model'
	
    get '/projects/:project_id/issues/custom_model_html/:id', :to => 'tab_setting#custom_model_html', :as => 'custom_model_html'
    