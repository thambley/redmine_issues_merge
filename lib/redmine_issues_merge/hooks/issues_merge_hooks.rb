# This class hooks into Redmine's View Listeners in order to add content to the page
class IssuesMergeHooks < Redmine::Hook::ViewListener
    render_on :view_issues_context_menu_start, :partial => 'issues_merge/update_context'
end
