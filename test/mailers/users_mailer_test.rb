require 'test_helper'

class UsersMailerTest < ActionMailer::TestCase
  test "signup_confirmation" do
    mail = UsersMailer.signup_confirmation
    assert_equal "Signup confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
