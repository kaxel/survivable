require "test_helper"

class ClimatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @climate = climates(:one)
  end

  test "should get index" do
    get climates_url
    assert_response :success
  end

  test "should get new" do
    get new_climate_url
    assert_response :success
  end

  test "should create climate" do
    assert_difference('Climate.count') do
      post climates_url, params: { climate: { cold_floor: @climate.cold_floor, cold_warm: @climate.cold_warm, intensity: @climate.intensity, name: @climate.name, trend: @climate.trend, warm_ceiling: @climate.warm_ceiling } }
    end

    assert_redirected_to climate_url(Climate.last)
  end

  test "should show climate" do
    get climate_url(@climate)
    assert_response :success
  end

  test "should get edit" do
    get edit_climate_url(@climate)
    assert_response :success
  end

  test "should update climate" do
    patch climate_url(@climate), params: { climate: { cold_floor: @climate.cold_floor, cold_warm: @climate.cold_warm, intensity: @climate.intensity, name: @climate.name, trend: @climate.trend, warm_ceiling: @climate.warm_ceiling } }
    assert_redirected_to climate_url(@climate)
  end

  test "should destroy climate" do
    assert_difference('Climate.count', -1) do
      delete climate_url(@climate)
    end

    assert_redirected_to climates_url
  end
end
