class ApplicationController < ActionController::Base
  around_action :user_time_zone, if: :current_user
  before_action :set_locale

  private

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end
end
