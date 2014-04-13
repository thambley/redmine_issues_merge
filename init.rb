# encoding: utf-8

require_dependency 'issues_merge_hooks'

Redmine::Plugin.register :redmine_issues_merge do
    name 'Redmine Issue Merge plugin'
    author 'Todd Hambley'
    description 'This is a plugin to merge issues in Redmine'
    version '0.1'

    #permission :merge_issues, :time_trackers => :index
    #Redmine::AccessControl.map do |map|
    #  map.project_module :issue_tracking do |map|
    #    map.permission :merge_issues, {:issues => [:confirm_merge, :merge]}
    #  end
    #end
    
    project_module :issue_tracking do
      permission :merge_issues , {:issues => [:confirm_merge, :merge]}, :require => :member
    end

end

require 'dispatcher' unless Rails::VERSION::MAJOR >= 3
 
if Rails::VERSION::MAJOR >= 3
   ActionDispatch::Callbacks.to_prepare do
     # use require_dependency if you plan to utilize development mode
     require 'issues_merge_patches'
   end
else
  Dispatcher.to_prepare do
    # use require_dependency if you plan to utilize development mode
    require 'issues_merge_patches'
  end
end