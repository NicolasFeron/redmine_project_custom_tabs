module CustomTabs
  class Hooks < Redmine::Hook::ViewListener
    def before_render_tabs(context={ })
      Redmine::MenuManager.map :project_menu do |menu|
        tab_settings = TabSetting.where(project_id: context[:project].id)
        tab_settings.each do |tab|
          if Redmine::MenuManager.items(:project_menu).root.children.map(&:name).include?(tab.tab_name.to_sym)            
            Redmine::MenuManager.map(:project_menu).delete(tab.tab_name.to_sym)
          end
          if tab.tab_url.blank?
            tab.tab_url = "http://" + context[:request].host_with_port.to_s + "/projects/dexia/issues/default"
            menu.push  tab.tab_name, tab.tab_url+'/'+tab.id.to_s
          else
            menu.push  tab.tab_name, tab.tab_url
          end
        end
      end
      return ""
    end
	      
    def view_layouts_base_html_head(context={})  
        "\n".html_safe + stylesheet_link_tag('custom_tabs', :plugin => :redmine_project_custom_tabs)        
    end          
      
  end
end