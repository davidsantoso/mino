class UsersController < ApplicationController
  # POST /users
  def create
    @user = User.create(user_create_params)

    if @user.errors.any?
      render json: @encrypted_response.build(@user.errors), status: :conflict
    else
      render json: @encrypted_response.build(@user), status: :created
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
    @data.require(:user).permit(:email,
                                :public_key,
                                :encrypted_private_key,
                                :nonce,
                                :salt)
  end
end
