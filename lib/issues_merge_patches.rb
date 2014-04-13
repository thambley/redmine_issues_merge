# use require_dependency if you plan to utilize development mode
require 'issue'
#require 'issues_helper'
require 'issues_controller'

module IssuesMerge
  module Patches
    module IssuePatch
      def self.included(base) # :nodoc:
        base.class_eval do
          unloadable

          def merge!(issues)
            # make sure user has permission to update this issue and read + delete issues
            # if issues is just one issue, make it the first element of an array
            # for each issue
            #   merge journal entries
            #   merge attachments
            #   merge relationships?
            #   call hook "merge" to notify plugins to merge
            #   delete merged issue
          end

        end
      end
    end
    
    module IssuesControllerPatch
      extend ActiveSupport::Concern
      
      included do
        unloadable
        
        prepend_before_filter :only => [:confirm_merge, :merge] do
          find_issues
        end
      end
      
      def confirm_merge
        flash[:notice] = ("TESTING")
        redirect_to :back
        #respond_to do |format|
        #  format.html { }
        #  format.xml  { }
        #end
      end
      
      def merge
        
      end
      
    end
  end
end

unless Issue.included_modules.include? IssuesMerge::Patches::IssuePatch
  Issue.send(:include, IssuesMerge::Patches::IssuePatch)
end

unless IssuesController.included_modules.include? IssuesMerge::Patches::IssuesControllerPatch
  IssuesController.send(:include, IssuesMerge::Patches::IssuesControllerPatch)
end