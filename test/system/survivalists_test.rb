require "application_system_test_case"

class SurvivalistsTest < ApplicationSystemTestCase
  setup do
    @survivalist = survivalists(:one)
  end

  test "visiting the index" do
    visit survivalists_url
    assert_selector "h1", text: "Survivalists"
  end

  test "creating a Survivalist" do
    visit survivalists_url
    click_on "New Survivalist"

    fill_in "Creativity", with: @survivalist.creativity
    fill_in "Determination", with: @survivalist.determination
    fill_in "Optimism", with: @survivalist.optimism
    fill_in "Skill", with: @survivalist.skill
    fill_in "Strength", with: @survivalist.strength
    click_on "Create Survivalist"

    assert_text "Survivalist was successfully created"
    click_on "Back"
  end

  test "updating a Survivalist" do
    visit survivalists_url
    click_on "Edit", match: :first

    fill_in "Creativity", with: @survivalist.creativity
    fill_in "Determination", with: @survivalist.determination
    fill_in "Optimism", with: @survivalist.optimism
    fill_in "Skill", with: @survivalist.skill
    fill_in "Strength", with: @survivalist.strength
    click_on "Update Survivalist"

    assert_text "Survivalist was successfully updated"
    click_on "Back"
  end

  test "destroying a Survivalist" do
    visit survivalists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Survivalist was successfully destroyed"
  end
end
