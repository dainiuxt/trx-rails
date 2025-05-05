class WorkoutsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_difficulty, only: %i[ new show edit update ]
  before_action :set_workout_type, only: %i[ new show edit update ]
  before_action :set_workout, only: %i[ show edit update ]
  before_action :set_exercises, only: %i[ new show edit update ]

  def index
    @workouts = Workout.all
  end

  def show
  end

  def new
    @workout = Workout.new
  end

  def create
    @workout = Workout.new(workout_params)
    if @workout.save
      redirect_to @workout
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @workout.update(workout_params)
      redirect_to @workout
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_workout
      @workout = Workout.includes(:difficulty, :workout_type, :exercises).find(params[:id])
    end

    def set_difficulty
      @difficulties = Difficulty.all.order(:id)
    end

    def set_workout_type
      @workout_types = WorkoutType.all.order(:id)
    end

    def set_exercises
      @exercises = Exercise.all
    end

    def workout_params
      params.expect(workout: [  :name,
                                :workout_description,
                                :difficulty_id,
                                :workout_type_id,
                                :duration,
                                exercise_ids: [] ])
    end
end
