Redmine Projects Custom tabs
=========================================

Desciption
------------
This plugin is used to dynamically add tabs in the project view.
The custom tab can display the result of an existing Redmine page, display a specific query or point an extrernal url.

This plugin add two new settings :
* one in the administration page
* the other in the project settings

The first allow an administrator to edit all the custom tabs for any project.

The second allow a manager to edit ll the custom tabs for his project.

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
```
bundle exec rake redmine:plugins:migrate
```


Usage
------------

There are three ways of using this plugin:
* Choose a query in the list wich will open in the new tab the selected query on a customisable page (work in progress)
* Set an internal URL like a query URL, an activity URL or a time consommed URL
* Set an external URL like an external wiki, a website or a GitHub URL