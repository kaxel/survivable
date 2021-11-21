require "application_system_test_case"

class PossessionsTest < ApplicationSystemTestCase
  setup do
    @possession = possessions(:one)
  end

  test "visiting the index" do
    visit possessions_url
    assert_selector "h1", text: "Possessions"
  end

  test "creating a Possession" do
    visit possessions_url
    click_on "New Possession"

    fill_in "Bonus", with: @possession.bonus
    fill_in "Current game", with: @possession.current_game_id
    fill_in "Name", with: @possession.name
    click_on "Create Possession"

    assert_text "Possession was successfully created"
    click_on "Back"
  end

  test "updating a Possession" do
    visit possessions_url
    click_on "Edit", match: :first

    fill_in "Bonus", with: @possession.bonus
    fill_in "Current game", with: @possession.current_game_id
    fill_in "Name", with: @possession.name
    click_on "Update Possession"

    assert_text "Possession was successfully updated"
    click_on "Back"
  end

  test "destroying a Possession" do
    visit possessions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Possession was successfully destroyed"
  end
end
