Redmine Projects Custom tabs
=========================================

Desciption
------------
This plugin is used to dynamically add tabs in the project view.
The custom tab can display the result of an existing Redmine page, display a specific query or point an extrernal url.

This plugin add two new settings for custom tabs:
* one in the administration page
* the other in the project settings

The first allow an administrator to edit all the custom tabs for any project.

The second allow a manager to edit ll the custom tabs for his project.

Now, the plugin allow to set a custom model for the custom tabs.
The model can be create and update by administrator and set to cutom tabs by manager.
The model is used to totaty customise the rendering on the tab (see the samples models in the sample directory)
See the [Wiki](https://github.com/NicolasFeron/redmine_project_custom_tabs/wiki) for the avalaibles helpers and css class (
library being fed).

Installation
------------
Unfortunately, there is no hook to manage the addition of modifying the project view.
It is necessary to add a hook in  *app/views/layouts/base.html.erb*, the line below :

```
<%= call_hook :before_render_tabs %>
```

Before the block

```
<div id="main-menu">
    <%= render_main_menu(@project) %>
</div>
```

Database Migration
------------

the plugin add the followings tables
* tab_settings
| Column Name          | Type    |
| ---------------------|---------|
| project              | integer |
| project_id           | integer |
| tab_name             | string  | 
| tab_url              | string  | 
| query_id             | integer |
| tab_setting_model_id | integer | 

* tab_setting_models
| Column Name          | Type    |
| ---------------------|---------|
| id                   | integer |
| name                 | string  | 
| conten               | string  | 


```
bundle exec rake redmine:plugins:migrate
```


Usage
------------

There are three ways of using this plugin:
* Choose a query in the list wich will open in the new tab the selected query :
** on a customisable page
** on the default view (the same rendering than the query issue view)
* Set an internal URL like a query URL, an activity URL or a time consommed URL (the same view of the selected page url)
* Set an external URL like an external wiki, a website or a GitHub URL