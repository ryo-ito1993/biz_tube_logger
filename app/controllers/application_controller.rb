class ApplicationController < ActionController::Base
  include Api::UserAuthenticator
  protect_from_forgery with: :null_session
end
