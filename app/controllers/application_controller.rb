class ApplicationController < ActionController::Base
  protect_from_forgery
  authenticates_using_session
  check_authorization unless: :auth_controller?
end
