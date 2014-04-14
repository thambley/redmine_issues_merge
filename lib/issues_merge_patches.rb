# use require_dependency if you plan to utilize development mode
require 'issue'
#require 'issues_helper'
require 'issues_controller'

module IssuesMerge
  module Patches
    module IssuePatch
      extend ActiveSupport::Concern
      
      included do # :nodoc:
        unloadable
        
        after_create :issue_created_journal
      end
      
      def merge!(issues)
        # make sure user has permission to update this issue and read + delete issues
        # if issues is just one issue, make it the first element of an array
        # for each issue
        #   merge journal entries
        #   merge attachments
        #   merge relationships?
        #   merge time entries
        #   merge watchers
        #   call hook "merge" to notify plugins to merge
        #   delete merged issue
      end
      
      # create invisible journal entry to use when merging
      def issue_created_journal
        new_issue_journal = Journal.new(:journalized => self, :user => User.current)
        dummy_detail = JournalDetail.new(:property => 'attr', :prop_key => :created_on, :value => self.created_on)
        new_issue_journal.details << dummy_detail
        new_issue_journal.notify = false
        new_issue_journal.save
        dummy_detail.delete
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

unless Issue.included_modules.include? IssuesMerge::Patches::IssuePatch
  Issue.send(:include, IssuesMerge::Patches::IssuePatch)
end

unless IssuesController.included_modules.include? IssuesMerge::Patches::IssuesControllerPatch
  IssuesController.send(:include, IssuesMerge::Patches::IssuesControllerPatch)
end