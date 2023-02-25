require "test_helper"

class TestmpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @testmp = testmps(:one)
  end

  test "should get index" do
    get testmps_url
    assert_response :success
  end

  test "should get new" do
    get new_testmp_url
    assert_response :success
  end

  test "should create testmp" do
    assert_difference("Testmp.count") do
      post testmps_url, params: { testmp: {  } }
    end

    assert_redirected_to testmp_url(Testmp.last)
  end

  test "should show testmp" do
    get testmp_url(@testmp)
    assert_response :success
  end

  test "should get edit" do
    get edit_testmp_url(@testmp)
    assert_response :success
  end

  test "should update testmp" do
    patch testmp_url(@testmp), params: { testmp: {  } }
    assert_redirected_to testmp_url(@testmp)
  end

  test "should destroy testmp" do
    assert_difference("Testmp.count", -1) do
      delete testmp_url(@testmp)
    end

    assert_redirected_to testmps_url
  end
end
