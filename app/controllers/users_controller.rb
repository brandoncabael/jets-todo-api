class UsersController < ApplicationController
  def update
    @user.update!(permitted_params)
    render json: UserSerializer.new(@user)
  end

  def delete
    @user.destroy!
    render json: { "message": "User successfully destroyed" }, status: 200
  end

  private
  def permitted_params
    params.permit(
      :name,
      :email
    )
  end
end
