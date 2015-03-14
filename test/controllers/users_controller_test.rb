require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    @request.headers["Accept"] = "application/json"
    @request.headers["Content-Type"] = "application/json"
  end

  # This is what the data attribute below should decrypt to
  # {
  #   data: {
  #     email: "daryl.dixon@mail.com",
  #     public_key: "Nak2khxef7Qn6HKemaj38T2/1x38AcIUAFPWLQtVby0=",
  #     encrypted_private_key: "yybVgE+zUyH6CkdnA8Jozbx13OsKmphyFlVTjxkSky7W2aYKx52RRXNs2PKOVztF"
  #     nonce: "bb0U33NFHg4QqlwtLL9oQY365ajvL4bv",
  #     salt: "AEoZJXoc6g7Tw1b3p1QtaNMFlFqqh12sZdBFGjXKx7c="
  #   },
  #   public_key: "Nak2khxef7Qn6HKemaj38T2/1x38AcIUAFPWLQtVby0=",
  #   nonce: "bb0U33NFHg4QqlwtLL9oQY365ajvL4bv"
  # }
  #
  # To recreate this exact payload-
  #
  # password: "secret"
  # scrypt genratedkey: "IVnS43pgVXnQGeiZcSzrjzbZ7+9j2CkECf2r74zuNO0="
  # unencrypted private key: "OQUWOJtLTme4nRs1ACClzq6PtaBWJBmo78ckIsn8nt4="
  #
  test "should create user" do
    assert_difference('User.count') do
      post :create, {
        data: "cdVQSa6X5hwLMA006r0e9AqgxIae4XcB3os7UreMW6DutBNpAzvNtYPTTEasvfFmXutvdIMhP2
          pqiRTdZYKQu7qsTDRV8FF9RQYp9StDoxDDIaPIb3JS0EsZ9IMPpdtOaqnxBLV0K/W9jsa1GGhB
          lOUO5wsgWALqHt5G65EaBN8+Ef5/Qe6VtNijdagYF++OMRlpSwvWRqYZ89FSG1i4b5feHTjLru
          Gc2gLHOohQ1sIylNCukIC77kWfYNZzOSWxso1HatSHoieYrJjeu+iaaGmdzgjLpPE1WRDGOJ3Y
          caa1wcErCePdtWF8jcxP5x5iCQ5U0jLHndf0HvZl8TC1f4759KSMhDraVdWS/9YKq/xoTuYDoE
          nhytmncgnEcB0yFnbySY+wnWSp4STilTur0ns=",
        public_key: "Nak2khxef7Qn6HKemaj38T2/1x38AcIUAFPWLQtVby0=",
        nonce: "bb0U33NFHg4QqlwtLL9oQY365ajvL4bv"
      }
    end

    user = assigns(:user)

    assert_empty user.errors
    assert_response :success
  end

  # Matches user one email fixture
  test "should return email already taken" do
    post :create, {
      data: "f/mO9k0mp7Bds9v8ZQNpcOYELqpAM0yV8Kczr0i0/XJ306bzXFL3DAhXJ3YPSoAMTLtafCKjCyE5
        YxdR7umK2W8H7kc637gGD6QrZHAE8uF10HYImZlOUihGeYZ+xTl1N+7TUeOiJUexBwT+7yZXCIcH
        1aqgliWKAEudci3WfgX7BCi1T5M5ShGU933jjptCMLPqkBRyCexRpChziMH1wZ+T+2JHVBZNFBK1
        Strg3DidnLDWdDjxyowI4R+0nI1SZuZEALrD64cs8wLYiOo9BhSbIfeDSBAHHQBOjqrIKBAaObUB
        vcJL4rD3gLFt/2+5Y+GQ+QJYcutSzWBosmUHWWPNqVuZATFCrDicu+nnr+hJe5/5k++niNSWtAV5
        /Iva5+0xsCFEdHICRubAFQRzA+U=",
      public_key: "QWiZxX4DAf45DW47DuxqI0ibFvRng1aV7oPvDx1QwwY=",
      nonce: "Txu23R/uBHWjyEIxofUbw6N+eK+Bb1gy"
    }

    user = assigns(:user)

    assert_not user.valid?
    assert_equal [:email], user.errors.keys
    assert_response :conflict
  end

  # Matches user two public key fixture
  test "should return public key already taken" do
    post :create, {
      data: "0S1ZRrx5udeanJca298E9Po9Fi8vYXdex2nA5NxgvKNT6/hO6Jsw60xr7aKy7e3oPtRPwLB8Qe86
        8H11nj6HY5rDC9HryqyvjKFFohTt8+ULD0wuUDURWk9cBq2ndgP9Fi1uC9WzifO5IhDc5oHLbisu
        b4aePPgkJ2+9SnBeUxS7cHsYKQZgmSD3bisjyT76ULbFP6CH2tCFMPHDdRKyelgsZvIy/rdiK+qP
        rC2LMc7yjMZMq2V/rXsAWoxTkdQagqZbrMOiG/frHDXydCCVeR+ZJ9zbXj48hDO53IxYJ42imt8i
        Rxx9s6VrB9jwW/q6GgN1rkCaTuYAKp/2B58PYrbgqhnqP77btynjlhdP5ZmrfLXile5HU/1baZMu
        wdi+V9Zq4NWKYDQhuu08mpc=",
      public_key: "u1J/opdSsZzBRO+AWch00Af13KDJcgb4WI57KDfkoxQ=",
      nonce: "y7Ti4KP44QenIL181vlKENRuidk/qrOH"
    }

    user = assigns(:user)

    assert_not user.valid?
    assert_equal [:public_key], user.errors.keys
    assert_response :conflict
  end

  # Matches user three encrypted private key fixture
  test "should return encrypted private key already taken" do
    post :create, {
      data: "wWrEEviPfW6CGnO4c6JCo2JmYMFQjtTDm277tZ2Ro16Koh3N3UQZHwAcD0uIsr+uW/FCK0JF0EA2
        j2RMRxZbU4aJya9jzdqHqgA5AhakenrW78jxPa/MDvKoPhA9X8ZQJE5WuiPeBFINIFORqay5NCGI
        lhzEspq4DCME9x8sCI9DIEV2ywCx7N6I6GBRC0CegfZg8DHu62iPoviKwrd8/w1PUMD4vtqa2rLL
        D/zboY/1rljgjKJpzRgbAiKctlOxykz8CuxysB1U02UNTX8A4fwln8C0ngsFE0sWDrOykMrmNC1b
        Ov7MYiJGIAwaUfeAwuWN8lr5FZNGdPVfg79rMaHHhJil9iYLIZEMwgKvAmcJ6czfhQiu2GIGG5FX
        /qwvHphEz9kJpU0gnr+C6DAsEA==",
      public_key: "m1fc7FUh1uQ7ta30j3xvsr73Dq+KO2k5YHWUgbYJHlI=",
      nonce: "uEpm4/ywZCnakQ1y21r3NVy1nlehWtbe"
    }

    user = assigns(:user)

    assert_not user.valid?
    assert_equal [:encrypted_private_key], user.errors.keys
    assert_response :conflict
  end

  test "should send email address verification email" do
    skip "Need to figure out how to best test an after_commit callback"
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :create, user: {email: "maggie.greene@mail.com", public_key: "htIBNjeNXgk", encrypted_private_key: "kmIIWHcsJQb==", nonce: "Hm27dm103ma", salt: "nI382bdkKd" }
    end
    email_address_verification_email = ActionMailer::Base.deliveries.last

    assert_enqueued_jobs(1)
    assert_equal "Verify your mino account", email_address_verification_email.subject
    assert_equal 'maggie.greene@mail.com', email_address_verification_email.to[0]
  end
end
