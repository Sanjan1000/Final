require 'dotenv'
JIRA_OPTIONS = {
  site: ENV['JIRA_SITE'],
  context_path: '',
  auth_type: :basic,
  username: ENV['JIRA_USERNAME'],
  password: ENV['JIRA_PASSWORD']
}
