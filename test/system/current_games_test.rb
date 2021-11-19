require "application_system_test_case"

class CurrentGamesTest < ApplicationSystemTestCase
  setup do
    @current_game = current_games(:one)
  end

  test "visiting the index" do
    visit current_games_url
    assert_selector "h1", text: "Current Games"
  end

  test "creating a Current game" do
    visit current_games_url
    click_on "New Current Game"

    fill_in "Ip", with: @current_game.ip
    fill_in "Sig", with: @current_game.sig
    click_on "Create Current game"

    assert_text "Current game was successfully created"
    click_on "Back"
  end

  test "updating a Current game" do
    visit current_games_url
    click_on "Edit", match: :first

    fill_in "Ip", with: @current_game.ip
    fill_in "Sig", with: @current_game.sig
    click_on "Update Current game"

    assert_text "Current game was successfully updated"
    click_on "Back"
  end

  test "destroying a Current game" do
    visit current_games_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Current game was successfully destroyed"
  end
end
