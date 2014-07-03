# encoding: utf-8
require 'redmine_issues_merge'

Redmine::Plugin.register :redmine_issues_merge do
    name 'Redmine Issue Merge plugin'
    author 'Todd Hambley'
    description 'This is a plugin to merge issues in Redmine'
    version '0.1'
    
    project_module :issue_tracking do
      permission :merge_issues , {:issues => [:confirm_merge, :merge]}, :require => :member
    end

end