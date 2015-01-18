class UsersController < ApplicationController

  # GET /users
  def index
    head 404, 'Content-Type' => 'application/json'
  end

  # GET /users/new
  def new
    head 404, 'Content-Type' => 'application/json'
  end

  # POST /users
  def create

  end

  # GET /users/:id
  def show
    head 404, 'Content-Type' => 'application/json'
  end

  # GET /users/:id/edit
  def edit
    head 404, 'Content-Type' => 'application/json'
  end

  # PUT /users/:id
  def update

  end

  # DELETE /users/id
  def destroy

  end
end
