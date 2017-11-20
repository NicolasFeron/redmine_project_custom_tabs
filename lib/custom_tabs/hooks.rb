module CustomTabs
  class Hooks < Redmine::Hook::ViewListener
    def before_render_tabs(context={ })
      Redmine::MenuManager.map :project_menu do |menu|
        tab_settings = TabSetting.all
        tab_settings.each do |tab|
          if Redmine::MenuManager.items(:project_menu).root.children.map(&:name).include?(tab.tab_name.to_sym) || !tab.project_id.eql?(context[:project].id)
            Redmine::MenuManager.map(:project_menu).delete(tab.tab_name.to_sym)
          end
          if tab.project_id.eql?(context[:project].id)
            if tab.tab_url.blank?
              server_url = Setting.plugin_redmine_project_custom_tabs['custom_tabs_server_url'].blank?? context[:request].host_with_port.to_s : Setting.plugin_redmine_project_custom_tabs['custom_tabs_server_url']
              server_url = server_url.chomp("http://")
              tab.tab_url = "http://#{server_url}/projects/#{context[:project].identifier}/issues/default"
              menu.push  tab.tab_name, tab.tab_url+'/'+tab.id.to_s
            else
              menu.push  tab.tab_name, tab.tab_url
            end
          end
        end
      end
      return ""
    end

    def view_layouts_base_html_head(context={})  
      "\n".html_safe + stylesheet_link_tag('custom_tabs', :plugin => :redmine_project_custom_tabs)  +  "\n".html_safe +
        stylesheet_link_tag('font-awesome-4.6.3/css/font-awesome.min.css', :plugin => "redmine_project_custom_tabs")
    end     
  end
end