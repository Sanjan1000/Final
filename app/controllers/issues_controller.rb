class IssuesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_jira_client, only: [:create_jira_issue]

  def new
    @referrer_url = request.referrer
    @post = Post.find_by(id: params[:post_id])
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

    ensure_jira_user_exists(current_user.email)

    post_title = params[:post_title]
    Rails.logger.info("Post title received: #{post_title}")

    issue = @jira_client.Issue.build
    issue_data = {
      'fields' => {
        'project' => { 'key' => 'SANJAN' },
        'summary' => params[:summary],
        'priority' => { 'name' => priority_map[params[:priority]] },
        'issuetype' => { 'name' => 'Task' },
        'customfield_10047' => current_user.email, # Use email directly for custom field
        'customfield_10041' => params[:referrer_url], # Replace with actual field ID for Link
        'customfield_10048' => post_title # Ensure this ID matches your "Collection" field ID
      }
    }

    Rails.logger.info("Creating Jira issue with data: #{issue_data}")

    begin
      issue.save!(issue_data)
      redirect_to root_path, notice: 'Jira issue created successfully.'
    rescue JIRA::HTTPError => e
      error_message = e.response.body
      Rails.logger.error("JIRA HTTP Error: #{error_message}")
      handle_jira_error(e)
    rescue => e
      Rails.logger.error("Unexpected error: #{e.message}")
      redirect_to new_jira_issue_path, alert: "Unexpected error: #{e.message}"
    end
  end

  private

  def ensure_jira_user_exists(email)
    begin
      Rails.logger.info("Jira user #{email} already exists.")
    rescue JIRA::HTTPError => e
      if e.response.code == '404'
        user_data = {
          'emailAddress' => email,
          'applicationKeys' => ['jira-software']
        }

        Rails.logger.info("Creating Jira user with data: #{user_data}")

        begin
          @jira_client.User.create(user_data)
        rescue JIRA::HTTPError => create_error
          Rails.logger.error("JIRA User Creation Error: #{create_error.response.body}")
          handle_jira_error(create_error)
        end
      else
        Rails.logger.error("JIRA HTTP Error: #{e.response.body}")
        handle_jira_error(e)
      end
    end
  end

  def handle_jira_error(error)
    error_message = error.response.body
    if error.response.code == '403'
      redirect_to new_jira_issue_path, alert: "Permission error: #{error_message}. Please check your Jira project permissions."
    else
      redirect_to new_jira_issue_path, alert: "Error: #{error_message}"
    end
  end
end
