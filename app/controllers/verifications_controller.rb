class VerificationsController < ApplicationController
  skip_before_filter :initialize_encrypted_response
  skip_before_filter :decrypt_request_data

  # GET /verifications
  # Unfortunately this isn't very RESTful. At some point in the future
  # it might be nice to have this action be a POST or a PUT/PATCH from
  # a client, but since at the moment it's going to be in the form of a
  # link in an email, GET is really the only option.
  def index
    verification = Verification.includes(:verifiable).find_by_token(params[:token])

    if verification && !verification.expired && verification.verifiable.verify(params)
      verification.expired = true
      verification.save

      render :index
    else
      head :forbidden
    end
  end
end
