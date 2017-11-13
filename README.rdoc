= Redmine Projects Custom tabs
=========================================

== Desciption
This plugin is used to dynamically add tabs in the project view.
The custom tab can display the result of an existing Redmine page, display a specific query or point an extrernal url.

== Installation
Unfortunately, there is no hook to manage the addition of modifying the project view.
It is necessary to add a hook in  *app/views/layouts/base.html.erb*, the line below :

```ruby
<%= call_hook :before_render_tabs %>
```

Before the block

```ruby
<div id="main-menu">
    <%= render_main_menu(@project) %>
</div>
```

== Database Migration
```ruby
bundle exec rake redmine:plugins:migrate
```