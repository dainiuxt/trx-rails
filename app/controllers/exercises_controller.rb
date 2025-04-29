class ExercisesController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_difficulty, only: %i[ new show edit update ]
  before_action :set_category, only: %i[ new show edit update ]
  before_action :set_muscle_groups, only: %i[ new show edit update ]
  before_action :set_exercise, only: %i[ show edit update ]

  def index
    @exercises = Exercise.all
  end

  def show
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

    def exercise_params
      params.expect(exercise: [ :name,
                                :description,
                                :instructions,
                                :tips,
                                :featured_image,
                                :plans,
                                :workouts,
                                :difficulty,
                                :sets,
                                :reps,
                                :rest,
                                :duration_time,
                                :is_time_based,
                                :difficulty_id,
                                :category_id,
                                muscle_group_ids: [] ])
    end
end
