class UsersController < ApplicationController

  # GET /users
  def index
    head 403, 'Content-Type' => 'application/json'
  end

  # GET /users/new
  def new
    head 403, 'Content-Type' => 'application/json'
  end

  # GET /users/:id
  def show
    head 403, 'Content-Type' => 'application/json'
  end

  # GET /users/:id/edit
  def edit
    head 403, 'Content-Type' => 'application/json'
  end

  # POST /users
  def create
    user = User.create(user_create_params)

    if user.errors.any?
      render json: user.errors.messages, status: :conflict
    else
      user.send_verification_token
      render json: user, status: :created
    end
  end

  # PUT /users/:id
  def update

  end

  # DELETE /users/id
  def destroy

  end

  # GET /users/verify
  def verify

  end

  private

  def user_create_params
    params.require(:user).permit(:email, :public_key, :encrypted_private_key)
  end
end
