require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise = exercises(:exercise_pushups)
  end

  test "should get index" do
    get exercise_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_url
    assert_response :success
  end

  test "should create exercise" do
    assert_difference("Exercise.count") do
      post exercises_url, params: {
        exercise: {
          name: "Test Exercise",
          difficulty_id: 1,
          category_id: 1
        }
      }
    end

    assert_redirected_to exercise_url(Exercise.last)
  end

  test "should show each exercise" do
    [ exercises(:exercise_pushups), exercises(:exercise_squats), exercises(:exercise_plank) ].each do |fixture_name, exercise|
      puts "Testing show for fixture: #{fixture_name}"
      get exercise_url(exercise)
      assert_response :success
    end
  end

  test "should get edit for each exercise" do
    [ exercises(:exercise_pushups), exercises(:exercise_squats), exercises(:exercise_plank) ].each do |fixture_name, exercise|
      puts "Testing edit for fixture: #{fixture_name}"
      get edit_exercise_url(exercise)
      assert_response :success
    end
  end

  test "should update each exercise" do
    [ exercises(:exercise_pushups), exercises(:exercise_squats), exercises(:exercise_plank) ].each do |fixture_name, exercise|
      puts "Testing update for fixture: #{fixture_name}"
      patch exercise_url(exercise), params: { exercise: { name: "Updated Name" } }
      assert_redirected_to exercise_url(exercise)
    end
  end

  test "should destroy each exercise" do
    [ exercises(:exercise_pushups), exercises(:exercise_squats), exercises(:exercise_plank) ].each do |fixture_name, exercise|
      puts "Testing destroy for fixture: #{fixture_name}"
      assert_difference("Exercise.count", -1) do
        delete exercise_url(exercise)
      end

      assert_redirected_to exercises_url
    end
  end
end
