require 'test_helper'

class CategotysControllerTest < ActionDispatch::IntegrationTest
  test "should get question" do
    get categotys_question_url
    assert_response :success
  end

  test "should get sns" do
    get categotys_sns_url
    assert_response :success
  end
end
