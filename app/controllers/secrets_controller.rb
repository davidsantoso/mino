class SecretsController < ApplicationController
  # POST /secrets
  def create
    user = User.find_by(public_key: params[:public_key])
    @secret = user.secrets.create(secret_params)

    if @secret.errors.any?
      render json: @encrypted_response.build(@secret.errors), status: :conflict
    else
      render json: @encrypted_response.build(@secret), status: :created
    end
  end

  # PUT /secrets/:id
  def update
    @secret = Secret.find(params[:id])
    @secret.update_attributes!(secret_params)

    if @secret.errors.any?
      render json: @encrypted_response.build(@secret.errors), status: :bad_request
    else
      render json: @encrypted_response.build(@secret), status: :ok
    end
  end

  # DELETE /secrets/:id
  def destroy

  end

  private

  # @data instance variable is being used instead of params because
  # there is the decrypt preprocess happening in application controller
  def secret_params
    @request_params.require(:secret).permit(:name,
                                            :url,
                                            :username,
                                            :password,
                                            :notes)
  end
end
