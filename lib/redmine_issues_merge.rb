require_dependency 'redmine_issues_merge/hooks/issues_merge_hooks'

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