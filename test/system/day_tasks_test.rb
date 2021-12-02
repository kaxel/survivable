require "application_system_test_case"

class DayTasksTest < ApplicationSystemTestCase
  setup do
    @day_task = day_tasks(:one)
  end

  test "visiting the index" do
    visit day_tasks_url
    assert_selector "h1", text: "Day Tasks"
  end

  test "creating a Day task" do
    visit day_tasks_url
    click_on "New Day Task"

    fill_in "Day", with: @day_task.day_id
    fill_in "Event", with: @day_task.event_id
    fill_in "Num", with: @day_task.num
    click_on "Create Day task"

    assert_text "Day task was successfully created"
    click_on "Back"
  end

  test "updating a Day task" do
    visit day_tasks_url
    click_on "Edit", match: :first

    fill_in "Day", with: @day_task.day_id
    fill_in "Event", with: @day_task.event_id
    fill_in "Num", with: @day_task.num
    click_on "Update Day task"

    assert_text "Day task was successfully updated"
    click_on "Back"
  end

  test "destroying a Day task" do
    visit day_tasks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Day task was successfully destroyed"
  end
end
