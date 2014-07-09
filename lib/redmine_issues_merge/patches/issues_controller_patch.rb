# use require_dependency if you plan to utilize development mode
require_dependency 'issues_controller'

module IssuesMerge
  module Patches
    module IssuesControllerPatch
      def self.included(base)
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)
      
        base.class_eval do
          unloadable
          
          prepend_before_filter :only => [:confirm_merge, :merge] do
            find_issues
          end
        end
      end
      
      module ClassMethods

      end

      module InstanceMethods
        def confirm_merge
          @issues.sort!
          
          respond_to do |format|
            format.html { }
          #  format.xml  { }
          end
        end
        
        def merge
          
        end
      end
    end
  end
end

unless IssuesController.included_modules.include? IssuesMerge::Patches::IssuesControllerPatch
  IssuesController.send(:include, IssuesMerge::Patches::IssuesControllerPatch)
end