require 'test_helper'

class SecretsControllerTest < ActionController::TestCase
  setup do
    @request.headers["Accept"] = "application/json"
    @request.headers["Content-Type"] = "application/json"
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
  test "should create secret" do
    assert_difference('Secret.count') do
      post :create, {
        data: "mUIYSGOdlpo7R783430sqpYDtHvRgzwVHyyIvX7AimHL80R0VfOqnbtXocaREE4NvMlrYi0Zac1J
          gihl4Ez+A1aVCSWPy8v+jO2WKS6Gh5LNddRv5XEMQ2qQ6Tnylmy+idGTGlwZLIhyPUkBVFE4huny
          12mfLXaQfhuQTrO+LEt+JpViGDa1t1qJJk3hBgKgDAsS7AP28yYIPAEdZhuq8F7WzqODCERcwDA=",
        public_key: "y/ZTKW2L5wRC/ZgwkMP3OM4J87/dd3snqXiqZu1U/Wk=",
        nonce: "h9PYYS+rRxXMfRvQfgsoaWJtM++1LDbd"
      }
    end

    secret = assigns(:secret)

    assert_empty secret.errors
    assert_response :success
  end
end
