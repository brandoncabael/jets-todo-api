class AuthenticationController < ApplicationController
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
      grant_token(user.id)
      render json: user
    else
      head 401
    end
  end

  def login
    user = User.find_by_email(params[:email])
    if user.password_hash == params[:password]
      grant_token(user.id)
      render json: user
    else
      head 401
    end
  end

  private

  def grant_token(user_id)
    JWT.encode User.find(user_id), nil, 'none'
  end
end
