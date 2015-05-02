class SecretsController < ApplicationController
  # POST /secrets
  def create
    user = User.find_by(public_key: params[:public_key])
    @secret = user.secrets.create(secret_create_params)

    if @secret.errors.any?
      render json: @encrypted_response.build(@secret.errors), status: :conflict
    else
      render json: @encrypted_response.build(@secret), status: :created
    end
  end

  # PUT /secrets/:id
  def update

  end

  # DELETE /secrets/:id
  def destroy

  end

  private

  # @data instance variable is being used instead of params because
  # there is the decrypt preprocess happening in application controller
  def secret_create_params
    @request_params.require(:secret).permit(:name,
                                            :url,
                                            :username,
                                            :password,
                                            :notes)
  end
end
