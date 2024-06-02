class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.update_user_theme(user, theme)
    user.update(theme: theme) if user.present? && %w[light dark].include?(theme)
  end
end
