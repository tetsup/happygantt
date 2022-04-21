class ApplicationController < ActionController::Base
  around_action :user_time_zone, if: :current_user
  before_action :set_locale

  def default_url_options(options = {})
    options.merge(locale: locale)
  end

  private

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def set_locale
    I18n.locale = locale
  end

  def locale
    params[:locale] || I18n.default_locale
  end
end
