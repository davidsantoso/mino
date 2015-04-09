class SessionsController < ApplicationController
  skip_before_filter :initialize_encrypted_response, :decrypt_request_data

  def create
    user = User.find_by_email(params[:email])

    if user && user.verified?
      client = user.clients.find_by_access_token(params[:access_token])

      # If a client with that access token exists, then set the session
      # and return the users data. If not, send client verification email to
      # verify they are the ones actually trying to access their data
      if client
        head 200
      else
        client = user.clients.new(access_token: params[:access_token])
        client.save

        head 202
      end
    else
      head 403
    end
  end

  def destroy

  end
end
