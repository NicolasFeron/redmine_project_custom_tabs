require_dependency 'custom_tabs/hooks'
Redmine::Plugin.register :redmine_project_custom_tabs do
	name 'Redmine Project custom tabs plugin'
	author 'Ali Ben El Hadj & Nicolas Feron'
	description "Plugin permettant d'ajouter des onglets aux projets à partir d'un lien ou d'une requete"
	version '1.0.1'
	url 'http://kantena.com'
	author_url 'http://kantena.com'

	Redmine::MenuManager.map :admin_menu do |menu|
		menu.push :custom_tabs, {:controller => 'tab_setting', :action => 'index'}, :caption => "Gestion des onglets"
		menu.push :custom_tab_models, {:controller => 'tab_setting_model', :action => 'index'}, :caption => "Gestion des modèles"
	end  
end
