require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    @request.headers["Accept"] = "application/json"
    @request.headers["Content-Type"] = "application/json"
  end
  #
  # test "index should return 403" do
  #   get :index
  #   assert_response :forbidden
  # end
  #
  # test "new should return 403" do
  #   get :new
  #   assert_response :forbidden
  # end
  #
  # test "show should return 403" do
  #   get :show, {id: 1}
  #   assert_response :forbidden
  # end
  #
  # test "edit should return 403" do
  #   get :edit, {id: 1}
  #   assert_response :forbidden
  # end

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
  # ---------------------------------------------------------------------------
  #
  # In Javascript:
  #
  # See http://doc.libsodium.org/password_hashing/README.html for masterKey generation
  #
  # masterKey = sodium.crypto_pwhash_scryptsalsa208sha256(
  #   "secret",
  #   salt,
  #   sodium.crypto_pwhash_scryptsalsa208sha256_OPSLIMIT_INTERACTIVE,
  #   sodium.crypto_pwhash_scryptsalsa208sha256_MEMLIMIT_INTERACTIVE,
  #   32
  # )
  #
  # ---------------------------------------------------------------------------
  #
  # See http://doc.libsodium.org/secret-key_cryptography/authenticated_encryption.html
  # for private key encryption
  #
  # encryptedPrivateKey = sodium.crypto_secretbox_easy(
  #   privateKey,
  #   nonce,
  #   masterKey)
  #
  # ---------------------------------------------------------------------------
  #
  # See http://doc.libsodium.org/public-key_cryptography/authenticated_encryption.html
  # for encrypting the entire payload to be later decrypted
  #
  # data = { user: { email: email,
  #                  public_key: sodium.to_base64(publicKey),
  #                  encrypted_private_key: sodium.to_base64(encryptedPrivateKey),
  #                  nonce: sodium.to_base64(nonce),
  #                  salt: sodium.to_base64(salt)
  #                }
  #              }
  #
  # encrypted_payload = sodium.crypto_box_easy(
  #   JSON.stringify(data),
  #   nonce,
  #   sodium.from_base64(minoPublicKey),
  #   privateKey
  # )
  #
  test "should create user" do
    assert_difference('User.count') do
      post :create, {
        data: "cdVQSa6X5hwLMA006r0e9AqgxIae4XcB3os7UreMW6DutBNpAzvNtYPTTEasvfFmXutvdIMhP2pqiRTdZYKQu7qsTDRV8FF9RQYp9StDoxDDIaPIb3JS0EsZ9IMPpdtOaqnxBLV0K/W9jsa1GGhBlOUO5wsgWALqHt5G65EaBN8+Ef5/Qe6VtNijdagYF++OMRlpSwvWRqYZ89FSG1i4b5feHTjLruGc2gLHOohQ1sIylNCukIC77kWfYNZzOSWxso1HatSHoieYrJjeu+iaaGmdzgjLpPE1WRDGOJ3Ycaa1wcErCePdtWF8jcxP5x5iCQ5U0jLHndf0HvZl8TC1f4759KSMhDraVdWS/9YKq/xoTuYDoEnhytmncgnEcB0yFnbySY+wnWSp4STilTur0ns=",
        public_key: "Nak2khxef7Qn6HKemaj38T2/1x38AcIUAFPWLQtVby0=",
        nonce: "bb0U33NFHg4QqlwtLL9oQY365ajvL4bv"
      }
    end

    user = assigns(:user)

    assert_empty user.errors
    assert_response :success
  end

  test "should return email already taken" do
    skip
    post :create, user: {email: "rick.grimes@mail.com", public_key: "MnIdIHANNgk", encrypted_private_key: "TmIcFFWzJBb==", nonce: "gEn5cq42ci", salt: "ipnEd5n21n"}
    user = assigns(:user)

    assert_not user.valid?
    assert_equal [:email], user.errors.keys
    assert_response :conflict
  end

  test "should return public key already taken" do
    skip
    post :create, user: {email: "michonne@mail.com", public_key: "MIIBIjANBgk", encrypted_private_key: "nmIEFdWRmBb==", nonce: "nnf8bAd83n", salt: "hN8d74s1nA" }
    user = assigns(:user)

    assert_not user.valid?
    assert_equal [:public_key], user.errors.keys
    assert_response :conflict
  end

  test "should return encrypted private key already taken" do
    skip
    post :create, user: {email: "michonne@mail.com", public_key: "htIBNjaNKgk", encrypted_private_key: "NmIIFHzBJBb==", nonce: "lD82nEom82", salt: "ke5oM1bf9A" }
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
