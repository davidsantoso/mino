class AuthenticationsController < ApplicationController

  # POST /authentications
  def create
    user = User.find_by_email(params[:user][:email])
    @authentication = user.authentications.create

    if @authentication.errors.any?
      render json: { errors: @authentication.errors }, status: :conflict
    else
      render :show, status: :created
    end
  end
end
