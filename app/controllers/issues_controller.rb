class IssuesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_jira_client

  def new
    @referrer_url = request.referrer
  end

  def create_jira_issue
    priority_map = {
      'High' => 'High',
      'Average' => 'Medium',
      'Low' => 'Low'
    }

    unless priority_map.keys.include?(params[:priority])
      redirect_to new_jira_issue_path, alert: "Invalid priority value. Must be one of: High, Average, Low."
      return
    end

    issue = @jira_client.Issue.build
    begin
      issue.save!({
        'fields' => {
          'project' => { 'key' => 'SANJAN' },
          'summary' => params[:summary],
          'priority' => { 'name' => priority_map[params[:priority]] },
          'issuetype' => { 'name' => 'Task' },
          'customfield_10041' => params[:referrer_url] # Replace with actual field ID for Link
        }
      })

      redirect_to root_path, notice: 'Jira issue created successfully.'
    rescue JIRA::HTTPError => e
      error_message = e.response.body
      Rails.logger.error("JIRA HTTP Error: #{error_message}")
      if e.response.code == '403'
        redirect_to new_jira_issue_path, alert: "Permission error: #{error_message}. Please check your Jira project permissions."
      else
        redirect_to new_jira_issue_path, alert: "Error creating Jira issue: #{error_message}"
      end
    rescue => e
      Rails.logger.error("Unexpected error: #{e.message}")
      redirect_to new_jira_issue_path, alert: "Unexpected error: #{e.message}"
    end
  end
end
