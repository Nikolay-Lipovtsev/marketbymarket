class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  # Force signout to prevent CSRF attacks
#  def handle_unverified_request
#    sign_out
#    super
#  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  before_action :set_locale

  private

  def set_locale
    if params[:locale] == "en"
      I18n.locale = params[:locale]
    else
      I18n.locale = I18n.default_locale
    end
  end
end
