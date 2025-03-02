Deface::Override.new :virtual_path => "wiki/show",
                     :name => "replace-url-for-new-wiki-link",
                     :replace => "erb[silent]:contains('User.current.allowed_to?(:edit_wiki_pages, @project)')",
                     :closing_selector => "erb[silent]:contains('end')",
                     :text => <<LINK
<% if controller.controller_name == 'documentation' %>
  <% if User.current.allowed_to?(:edit_documentation_pages, @project) %>
    <%= link_to l(:label_documentation_page_new), 
      new_project_documentation_page_path(@project, :parent => @page.title), 
      remote: true,
      class: 'icon icon-add' %>
  <% end %>
<% else %>
  <% if User.current.allowed_to?(:edit_wiki_pages, @project) %>
    <%= link_to l(:label_wiki_page_new), 
      new_project_wiki_page_path(@project, :parent => @page.title), 
      remote: true,
      class: 'icon icon-add' %>
  <% end %>
<% end %>
LINK

Deface::Override.new :virtual_path => "wiki/show",
                     :name => "adapt-export-wiki-permissions",
                     :replace => "erb[silent]:contains('User.current.allowed_to?(:export_wiki_pages, @project)')",
                     :partial => "documentation/export_links"

Deface::Override.new :virtual_path => "wiki/show",
                     :name => "adapt-link-to-diff",
                     :replace => "erb[loud]:contains('link_to l(:label_diff)')",
                     :text => <<EOS
<%= link_to l(:label_diff), :action => 'diff',
  :id => @page.title, :project_id => @page.project,
  :version => @content.version %>
EOS

Deface::Override.new :virtual_path => "wiki/show",
                     :name => "adapt-add-attachment-form",
                     :replace => "erb[loud]:contains('form_tag')",
                     :text => <<FORM_TAG
    <%= form_tag({:controller => controller.controller_name, :action => 'add_attachment',
                  :project_id => @project, :id => @page.title},
                 :multipart => true, :id => "add_attachment_form") do %>
FORM_TAG
