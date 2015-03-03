class UsersController < ApplicationController

  # GET /users
  def index
    head :forbidden
  end

  # GET /users/new
  def new
    head :forbidden
  end

  # GET /users/:id
  def show
    head :forbidden
  end

  # GET /users/:id/edit
  def edit
    head :forbidden
  end

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

  def user_create_params
    params.require(:user).permit(:email, :public_key, :encrypted_private_key, :nonce)
  end
end
