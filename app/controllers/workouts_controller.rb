class WorkoutsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_difficulty, only: %i[ new show edit update ]
  before_action :set_workout_type, only: %i[ new show edit update ]
  before_action :set_workout, only: %i[ show edit update ]

  def index
    @workouts = Workout.all
  end

  def show
    
  end

  def new
    @workout = Workout.new
    @workout.plans.build
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
    unless params[:workout][:plans_attributes]
      params[:workout][:plans_attributes] = {}
    end

    if @workout.update(workout_params)
      redirect_to @workout
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_workout
      @workout = Workout.includes(:difficulty, :workout_type).find(params[:id])
    end

    def set_difficulty
      @difficulties = Difficulty.all.order(:id)
    end

    def set_workout_type
      @workout_types = WorkoutType.all.order(:id)
    end

    def workout_params
      params.require(:workout).permit(
        :name,
        :workout_description,
        :difficulty_id,
        :duration,
        :workout_type_id,
        plans_attributes: [
          :id,
          :exercise_id,
          :sets,
          :reps,
          :rest,
          :duration_time,
          :is_time_based,
          :position,
          :_destroy
        ]
      )
    end
end
