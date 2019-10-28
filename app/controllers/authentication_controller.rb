class AuthenticationController < ApplicationController
  skip_before_action :load_user

  def register
    if params && \
      params[:email] && \
      params[:password] && \
      params[:password_confirmation] && \
      params[:password] == params[:password_confirmation] && \
      params[:name]

      hashed = BCrypt::Password.create(params[:password])
      user = User.create!(
        email: params[:email],
        password_hash: hashed,
        name: params[:name]
      )
      token = grant_token(user.id)
      set_header("access_token", token)
      render json: UserSerializer.new(
        user
      ), status: :ok
    else
      render json: { "mesage": "Invalid request" }, status: 401
    end
  end

  def login
    user = User.find_by_email(params[:email])
    if user
      if BCrypt::Password.new(user.password_hash) == params[:password]
        token = grant_token(user.id)
        set_header("access_token", token)
        render json: UserSerializer.new(
          user
        ), status: :ok
      else
        render json: { "mesage": "Incorrect Password" }, status: 401
      end
    else
      render json: { "message": "Incorrect credentials, please try again" }, status: 400
    end
  end

  private

  def grant_token(user_id)
    JWT.encode User.find(user_id).serializable_hash, nil, 'none'
  end
end
