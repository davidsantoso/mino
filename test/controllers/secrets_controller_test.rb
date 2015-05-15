require 'test_helper'

class SecretsControllerTest < ActionController::TestCase
  setup do
    @request.headers["Accept"] = "application/json"
    @request.headers["Content-Type"] = "application/json"
  end

  test "should return 400 because of bad decrypt" do
    post :create, {
      data: "incorrectly_encrypted_message",
      public_key: "y/ZTKW2L5wRC/ZgwkMP3OM4J87/dd3snqXiqZu1U/Wk=",
      nonce: "Pc0zdJN4H24dc6wtaLdoEY38YajRL4xv"
    }

    assert_response :bad_request
  end

  test "should return 400 because blank public key" do
    post :create, {
      data: "some_encrypted_message",
      public_key: "",
      nonce: "yc0zdMN4x242c6DtadCoEd3WQa1R14xC"
    }

    assert_response :bad_request
  end

  test "should return 400 because of blank nonce" do
    post :create, {
      data: "some_encrypted_message",
      public_key: "y/ZTKW2L5wRC/ZgwkMP3OM4J87/dd3snqXiqZu1U/Wk=",
      nonce: ""
    }

    assert_response :bad_request
  end

  # This is what the data attribute below should decrypt to
  # {
  #   data: {
  #     secret: {
  #       name: "Google",
  #       url: "www.google.com",
  #       username: "test.user"
  #       password: "some_password",
  #       notes: "Lorem ipsum"
  #     }
  #   },
  #   public_key: "Nak2khxef7Qn6HKemaj38T2/1x38AcIUAFPWLQtVby0=",
  #   nonce: "i+ZapKXfxmiHVnQAavSQf4GVKUvbxYep"
  # }
  test "should create a secret" do
    assert_difference('Secret.count') do
      post :create, {
        data: "mUIYSGOdlpo7R783430sqpYDtHvRgzwVHyyIvX7AimHL80R0VfOqnbtXocaREE4N
          vMlrYi0Zac1Jgihl4Ez+A1aVCSWPy8v+jO2WKS6Gh5LNddRv5XEMQ2qQ6Tnylmy+idGTG
          lwZLIhyPUkBVFE4huny12mfLXaQfhuQTrO+LEt+JpViGDa1t1qJJk3hBgKgDAsS7AP28y
          YIPAEdZhuq8F7WzqODCERcwDA=",
        public_key: "y/ZTKW2L5wRC/ZgwkMP3OM4J87/dd3snqXiqZu1U/Wk=",
        nonce: "h9PYYS+rRxXMfRvQfgsoaWJtM++1LDbd"
      }
    end

    secret = assigns(:secret)

    assert_empty secret.errors
    assert_response :success
  end

  # This is what the data attribute below should decrypt to
  # {
  #   data: {
  #     secret: {
  #       name: "Google",
  #       url: "www.google.com",
  #       username: "test.user"
  #       password: "some_password",
  #       notes: "Lorem ipsum password updated"
  #     }
  #   },
  #   public_key: "y/ZTKW2L5wRC/ZgwkMP3OM4J87/dd3snqXiqZu1U/Wk=",
  #   nonce: "NqXmrwpN38nh2ymPWkfJBRD53EvMT9k8"
  # }
  test "should update a secret" do
    put :update, {
      id: 1,
      data: "tJGeeuRsR/YoLs1BzKPgGQxOrMsWP4D932YGMZ4D2nCNKSjLcUGY0Is7BvPrJnVv1t7
      KDaW+DOWSSvX72pmr71EO2qekdqVaKDyFVND3AQPtU01OwDVx6yXW/rpJ8OZsmV4Fbd89F6n4m
      lsSwPxxPNuxxxeoZrddw2jiyXwvEv2nfeU5RgRGgn0IimlKNwXFGQKma/g55QyFsr1fXAKXfTc
      5nK0ejqWfT3cC3mzO5Z28LqU8Ke4o42ISxg==",
      public_key: "y/ZTKW2L5wRC/ZgwkMP3OM4J87/dd3snqXiqZu1U/Wk=",
      nonce: "NqXmrwpN38nh2ymPWkfJBRD53EvMT9k8"
    }

    secret = assigns(:secret)

    assert_equal "Lorem ipsum password updated", secret.notes
    assert_equal "test.user", secret.username
    assert_empty secret.errors
    assert_response :ok
  end
end
