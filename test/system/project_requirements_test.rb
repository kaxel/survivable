require "application_system_test_case"

class ProjectRequirementsTest < ApplicationSystemTestCase
  setup do
    @project_requirement = project_requirements(:one)
  end

  test "visiting the index" do
    visit project_requirements_url
    assert_selector "h1", text: "Project Requirements"
  end

  test "creating a Project requirement" do
    visit project_requirements_url
    click_on "New Project Requirement"

    fill_in "Project", with: @project_requirement.project_id
    fill_in "Requirement", with: @project_requirement.requirement_id
    click_on "Create Project requirement"

    assert_text "Project requirement was successfully created"
    click_on "Back"
  end

  test "updating a Project requirement" do
    visit project_requirements_url
    click_on "Edit", match: :first

    fill_in "Project", with: @project_requirement.project_id
    fill_in "Requirement", with: @project_requirement.requirement_id
    click_on "Update Project requirement"

    assert_text "Project requirement was successfully updated"
    click_on "Back"
  end

  test "destroying a Project requirement" do
    visit project_requirements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Project requirement was successfully destroyed"
  end
end
