require "application_system_test_case"

class AdjustmentsTest < ApplicationSystemTestCase
  setup do
    @adjustment = adjustments(:one)
  end

  test "visiting the index" do
    visit adjustments_url
    assert_selector "h1", text: "Adjustments"
  end

  test "creating a Adjustment" do
    visit adjustments_url
    click_on "New Adjustment"

    fill_in "Amount", with: @adjustment.amount
    fill_in "Bonus", with: @adjustment.bonus
    fill_in "Project", with: @adjustment.project_id
    click_on "Create Adjustment"

    assert_text "Adjustment was successfully created"
    click_on "Back"
  end

  test "updating a Adjustment" do
    visit adjustments_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @adjustment.amount
    fill_in "Bonus", with: @adjustment.bonus
    fill_in "Project", with: @adjustment.project_id
    click_on "Update Adjustment"

    assert_text "Adjustment was successfully updated"
    click_on "Back"
  end

  test "destroying a Adjustment" do
    visit adjustments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Adjustment was successfully destroyed"
  end
end
