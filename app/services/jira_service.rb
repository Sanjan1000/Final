require 'net/http'
require 'json'

class JiraService
  API_URL = "#{JIRA_OPTIONS[:site]}/rest/api/3/search"

  def initialize(user)
    @user = user
  end

  def fetch_tickets
    uri = URI(API_URL)
    query = {
      jql: "cf[10047] ~ \"#{@user.email}\"",
      fields: 'summary,status,issuetype,priority'
    }
    uri.query = URI.encode_www_form(query)

    request = Net::HTTP::Get.new(uri)
    request.basic_auth(JIRA_OPTIONS[:username], JIRA_OPTIONS[:password])
    request['Accept'] = 'application/json'

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    return [] unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)['issues']
  end
end