require "test_helper"

class SurvivalistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survivalist = survivalists(:one)
  end

  test "should get index" do
    get survivalists_url
    assert_response :success
  end

  test "should get new" do
    get new_survivalist_url
    assert_response :success
  end

  test "should create survivalist" do
    assert_difference('Survivalist.count') do
      post survivalists_url, params: { survivalist: { creativity: @survivalist.creativity, determination: @survivalist.determination, optimism: @survivalist.optimism, skill: @survivalist.skill, strength: @survivalist.strength } }
    end

    assert_redirected_to survivalist_url(Survivalist.last)
  end

  test "should show survivalist" do
    get survivalist_url(@survivalist)
    assert_response :success
  end

  test "should get edit" do
    get edit_survivalist_url(@survivalist)
    assert_response :success
  end

  test "should update survivalist" do
    patch survivalist_url(@survivalist), params: { survivalist: { creativity: @survivalist.creativity, determination: @survivalist.determination, optimism: @survivalist.optimism, skill: @survivalist.skill, strength: @survivalist.strength } }
    assert_redirected_to survivalist_url(@survivalist)
  end

  test "should destroy survivalist" do
    assert_difference('Survivalist.count', -1) do
      delete survivalist_url(@survivalist)
    end

    assert_redirected_to survivalists_url
  end
end
