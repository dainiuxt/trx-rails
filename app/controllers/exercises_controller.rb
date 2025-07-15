class ExercisesController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :require_admin, only: %i[ new edit update ]
  before_action :set_difficulty, only: %i[ new show edit update ]
  before_action :set_category, only: %i[ new show edit update ]
  before_action :set_muscle_groups, only: %i[ new show edit update ]
  before_action :set_exercise, only: %i[ show edit update ]
  before_action :set_workouts, only: %i[ new show edit update ]

  def index
    @categories = Category.all
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @exercises = @category.exercises
    else
      @exercises = Exercise.all
    end
  end

  def show
    if params[:plan_id]
      @plan = Plan.find_by(id: params[:plan_id])
      @workout = @plan&.workout
    end
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
      redirect_to @exercise
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to @exercise
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_exercise
      @exercise = Exercise.includes(:difficulty, :category, :muscle_groups).find(params[:id])
    end

    def set_difficulty
      @difficulties = Difficulty.all.order(:id)
    end

    def set_category
      @categories = Category.all.order(:id)
    end

    def set_muscle_groups
      @muscle_groups = MuscleGroup.all
    end

    def set_workouts
      @workouts = Workout.all
    end

    def exercise_params
      params.expect(exercise: [ :name,
                                :description,
                                :instructions,
                                :tips,
                                :precautions,
                                :featured_image,
                                :plans,
                                :difficulty,
                                :difficulty_id,
                                :category_id,
                                :video_link,
                                workout_ids: [],
                                muscle_group_ids: [] ])
    end
end
