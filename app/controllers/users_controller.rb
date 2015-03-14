class UsersController < ApplicationController
  before_filter :decrypt_request_data, except: [:index, :new, :show, :edit]

  # POST /users
  def create
    @user = User.create(user_create_params)

    if @user.errors.any?
      render json: { errors: @user.errors }, status: :conflict
    else
      render :show, status: :created
    end
  end

  # PUT /users/:id
  def update

  end

  # DELETE /users/:id
  def destroy

  end

  private

  # @data instance variable is being used instead of params because
  # there is the decrypt preprocess happening in application controller
  def user_create_params
    @data.require(:user).permit(:email, :public_key, :encrypted_private_key, :nonce, :salt)
  end
end
