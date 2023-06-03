class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :switch_locale

  private

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    user_advrials_path(resource)
  end

    # ログアウト後のリダイレクト先
    def after_sign_out_path_for(resource_or_scope)
      new_user_session_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys:[:account_name])
    end

    def switch_locale(&action)
      locale = params[:locale] || :ja
      I18n.with_locale(locale, &action)
    end

    def user_not_authorized
      flash[:alert] = t('common.actions.policy_error')
      redirect_to(request.referrer || root_path)
    end
end
