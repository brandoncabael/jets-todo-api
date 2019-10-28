class ApplicationController < Jets::Controller::Base
  require 'bcrypt'
  require 'jwt'

  before_action :load_user

  private
  def load_user
    decoded_token = JWT.decode request.headers["access-token"], nil, false
    @user = User.find(decoded_token[0]["id"])
    unless @user
      render json: { "message": "Missing access token" }, status: 400
    end
  end
end
