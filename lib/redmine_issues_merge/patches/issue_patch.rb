# use require_dependency if you plan to utilize development mode
require_dependency 'issue'

module IssuesMerge
  module Patches
    module IssuePatch
      def self.included(base)
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)
      
        base.class_eval do
          unloadable
          
          after_create :issue_created_journal
        end
      end
      
      module ClassMethods

      end

      module InstanceMethods
        # create invisible journal entry to use when merging
        def issue_created_journal
          new_issue_journal = Journal.new(:journalized => self, :user => User.current)
          dummy_detail = JournalDetail.new(:property => 'attr', :prop_key => :created_on, :value => self.created_on)
          new_issue_journal.details << dummy_detail
          new_issue_journal.notify = false
          new_issue_journal.save
          dummy_detail.delete
        end

        # should move to service class:
        #def merge!(issues)
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
        #end
      end
    end
  end
end

unless Issue.included_modules.include? IssuesMerge::Patches::IssuePatch
  Issue.send(:include, IssuesMerge::Patches::IssuePatch)
end