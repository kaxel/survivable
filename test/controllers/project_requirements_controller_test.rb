require "test_helper"

class ProjectRequirementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project_requirement = project_requirements(:one)
  end

  test "should get index" do
    get project_requirements_url
    assert_response :success
  end

  test "should get new" do
    get new_project_requirement_url
    assert_response :success
  end

  test "should create project_requirement" do
    assert_difference('ProjectRequirement.count') do
      post project_requirements_url, params: { project_requirement: { project_id: @project_requirement.project_id, requirement_id: @project_requirement.requirement_id } }
    end

    assert_redirected_to project_requirement_url(ProjectRequirement.last)
  end

  test "should show project_requirement" do
    get project_requirement_url(@project_requirement)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_requirement_url(@project_requirement)
    assert_response :success
  end

  test "should update project_requirement" do
    patch project_requirement_url(@project_requirement), params: { project_requirement: { project_id: @project_requirement.project_id, requirement_id: @project_requirement.requirement_id } }
    assert_redirected_to project_requirement_url(@project_requirement)
  end

  test "should destroy project_requirement" do
    assert_difference('ProjectRequirement.count', -1) do
      delete project_requirement_url(@project_requirement)
    end

    assert_redirected_to project_requirements_url
  end
end
