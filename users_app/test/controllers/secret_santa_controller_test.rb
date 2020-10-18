require 'test_helper'

class SecretSantaControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get secret_santa_create_url
    assert_response :success
  end

end
