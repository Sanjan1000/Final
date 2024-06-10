class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_query
  def set_query
    @query = Post.ransack(params[:q])
  end

  def update_theme
    if current_user.present?
      ApplicationRecord.update_user_theme(current_user, params[:theme])
      render json: { status: 'ok' }
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  private

  def get_jira_client
    @jira_client = JIRA::Client.new(JIRA_OPTIONS)
  end
end
