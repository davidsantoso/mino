require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  setup do
    @request.headers["Accept"] = "application/json"
    @request.headers["Content-Type"] = "application/json"
  end

  test "it should return a 403 if it it can't find a users email address" do
    post :create, {
      email: "the.governor@mail.com",
      client_access_token: "89cc40df964b910d1e0dea67e394
      76a1ee5cb66db51fd627aca2e798526a56d6df58013f1b650f
      4cf67911017338e2bfe86496bae326b9f942951ccc429bb61e"
    }

    assert_response :forbidden
  end

  test "it should return a 403 if the email address is not verified" do
    post :create, {
      email: "sasha@mail.com",
      client_access_token: "86f4f686ebadcf89407a830d05e6
      19ce4921ac6622eaedbd1a8a98bd7c57f92241b59f9b206c30
      32f98344adb66ce6f0d35e809b3aff0288309b21aabe7ae803"
    }

    assert_response :forbidden
  end

  test "it should return 202 if the client token is unrecognized" do
    post :create, {
      email: "beth.greene@mail.com",
      client_access_token: "db64fa21a8324f57d03a3f0ff0c0
      bafd1d2071b895d53c73494fedd06f965c0616f50b94621489
      a166ba518a5cc89b7504d80a317966bc6d1df9c78d3ea84b8d"
    }

    assert_response 202
  end

  test "it should send client verification email if it can't find a client" do
    skip "Reevaluating session controller usage"
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :create, user: {
        email: "beth.greene@mail.com",
        client_access_token: "9b91ba0c478819f7b7ecc4ebffae
        7f5a4f1762eb07dfcef1fdfb2dd19b7dc6bd65fc493be0e310
        9cad0eed89b57d11ec1d38f7223738ef10b2e274262470fd86"
      }
    end
    client_verification_email = ActionMailer::Base.deliveries.last

    assert_enqueued_jobs(1)
    assert_equal "Verify your recent login attempt", client_verification_email.subject
    assert_equal 'beth.greene@mail.com', client_verification_email.to[0]
  end
end
