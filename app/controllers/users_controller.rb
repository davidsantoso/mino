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
end
