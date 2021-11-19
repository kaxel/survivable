require "test_helper"

class CurrentGamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_game = current_games(:one)
  end

  test "should get index" do
    get current_games_url
    assert_response :success
  end

  test "should get new" do
    get new_current_game_url
    assert_response :success
  end

  test "should create current_game" do
    assert_difference('CurrentGame.count') do
      post current_games_url, params: { current_game: { ip: @current_game.ip, sig: @current_game.sig } }
    end

    assert_redirected_to current_game_url(CurrentGame.last)
  end

  test "should show current_game" do
    get current_game_url(@current_game)
    assert_response :success
  end

  test "should get edit" do
    get edit_current_game_url(@current_game)
    assert_response :success
  end

  test "should update current_game" do
    patch current_game_url(@current_game), params: { current_game: { ip: @current_game.ip, sig: @current_game.sig } }
    assert_redirected_to current_game_url(@current_game)
  end

  test "should destroy current_game" do
    assert_difference('CurrentGame.count', -1) do
      delete current_game_url(@current_game)
    end

    assert_redirected_to current_games_url
  end
end
