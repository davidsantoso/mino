require 'test_helper'

# An anonymous controller with simple actions to make fake requests against so
# we can test before_filters in the action controller without needing to use a
# controller that we're using for real requests and testing elsewhere
class AnonymousController < ApplicationController
  def index
    render text: "Fake action to test initialize_encrypted_response before filter"
  end

  def show
    render text: "Fake action to test decrypt_request_data before filter"
  end
end

# We're making requests against our anonymous controller, but since it's not a
# real controller with routes in config/routes.rb, we need to generate the routes
# on the fly and use them within the scope of the test
class AnonymousControllerTest < ActionController::TestCase
  setup do
    @controller = AnonymousController.new
  end

  # This is testing the initialize_encrypted_response before filter. We want
  # to make sure that we've been sent a legitimate public key so we can
  # instaniate the box to encrypt data we want to send back
  test "it should return 400 if public key is not correct byte length" do
    with_routing do |set|
      set.draw { get "index/:public_key" => "anonymous#index" }
      get :index, { public_key: "incorrect_byte_length" }

      assert_response :bad_request
    end
  end

  # This is testing the initialize_encrypted_response before filter. If we've
  # been sent a correctly formatted public key, then it should have
  # successfully initialized
  test "it should instantiate a new EncryptedResponse" do
    with_routing do |set|
      set.draw do
        get "index/:public_key" => "anonymous#index"
      end

      get :index, { public_key: "uac2kExe77Qx6HKemaj38T2/1x38Ac8UcFPdLQ8Vby9=" }
      encrypted_response = assigns(:encrypted_response)

      assert_not_nil encrypted_response
    end
  end

  # This is testing the decrypt_request_data before filter. If we've
  # received a request that did not have a nonce, then we should return
  # 400 since we'll need a nonce to decrypt the request data
  test "it should return 400 if nonce is blank" do
    with_routing do |set|
      set.draw do
        get "show" => "anonymous#show"
      end

      get :show, { nonce: "", public_key: "uac2kExe77Qx6HKemaj38T2/1x38Ac8UcFPdLQ8Vby9=" }


      assert_response :bad_request
    end
  end

  # This is testing the decrypt_request_data before filter. Assuming that
  # we have a proper public key and nonce, we need to make sure we can decrypt
  # the request data. If not, something went wrong and we return a 400
  test "it should return 400 if data is not encrypted properly" do
    with_routing do |set|
      set.draw do
        get "show" => "anonymous#show"
      end

      get :show, { data: "incorrectly_encrypted_data", public_key: "uac2kExe77Qx6HKemaj38T2/1x38Ac8UcFPdLQ8Vby9="}

      assert_response :bad_request
    end
  end
end

class ApplicationControllerTest < ActionController::TestCase

  test "verification should return 403 without params" do
    get :verification
    assert_response :forbidden
  end

  test "verification should return 403 without email param" do
    get :verification, {token: "nfAen2193nS"}
    assert_response :forbidden
  end

  test "verification should return 403 without token param" do
    get :verification, {email: "sasha@mail.com"}
    assert_response :forbidden
  end

  test "verification should return 403 if token does not match" do
    get :verification, {email: "sasha@mail.com", token: "the_incorrect_token"}
    assert_response :forbidden
  end

  test "verification should set user to verified true if token does match" do
    # setup sets headers to application/json by default since it's normally
    # just responding to API requests so we need to override for this test
    @request.headers["Accept"] = "text/html"
    @request.headers["Content-Type"] = "text/html"

    get :verification, {email: "sasha@mail.com", token: "TH0s7wfHfzqFWTMB21pRgy9aTrMlDecFv"}

    @user = users(:two)

    assert_response :ok
    assert_equal true, @user.verified
    assert_template :verification
  end

  test "verification should render verification view if token does match" do
    # setup sets headers to application/json by default since it's normally
    # just responding to API requests so we need to override for this test
    @request.headers["Accept"] = "text/html"
    @request.headers["Content-Type"] = "text/html"

    get :verification, {email: "sasha@mail.com", token: "TH0s7wfHfzqFWTMB21pRgy9aTrMlDecFv"}

    assert_response :ok
    assert_template :verification
  end
end
