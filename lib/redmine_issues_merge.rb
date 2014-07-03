require_dependency 'redmine_issues_merge/hooks/view_issues_context_menu_start_hook'

require 'dispatcher' unless Rails::VERSION::MAJOR >= 3
 
if Rails::VERSION::MAJOR >= 3
   ActionDispatch::Callbacks.to_prepare do
     # use require_dependency if you plan to utilize development mode
     require 'redmine_issues_merge/patches/issue_patch'
   end
else
  Dispatcher.to_prepare do
    # use require_dependency if you plan to utilize development mode
    rrequire 'redmine_issues_merge/patches/issue_patch'
  end
end