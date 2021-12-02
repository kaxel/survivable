require "test_helper"

class DayTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @day_task = day_tasks(:one)
  end

  test "should get index" do
    get day_tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_day_task_url
    assert_response :success
  end

  test "should create day_task" do
    assert_difference('DayTask.count') do
      post day_tasks_url, params: { day_task: { day_id: @day_task.day_id, event_id: @day_task.event_id, num: @day_task.num } }
    end

    assert_redirected_to day_task_url(DayTask.last)
  end

  test "should show day_task" do
    get day_task_url(@day_task)
    assert_response :success
  end

  test "should get edit" do
    get edit_day_task_url(@day_task)
    assert_response :success
  end

  test "should update day_task" do
    patch day_task_url(@day_task), params: { day_task: { day_id: @day_task.day_id, event_id: @day_task.event_id, num: @day_task.num } }
    assert_redirected_to day_task_url(@day_task)
  end

  test "should destroy day_task" do
    assert_difference('DayTask.count', -1) do
      delete day_task_url(@day_task)
    end

    assert_redirected_to day_tasks_url
  end
end
