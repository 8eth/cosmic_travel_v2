class ScientistsController < ApplicationController
    def index
        scientists = Scientist.all
        render json: scientists, except: [:created_at, :updated_at]
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json:scientist, status: :created, except: [:created_at, :updated_at]
    end

    def show
        scientist = find_scientist
        render json:scientist, except: [:created_at, :updated_at], serializer: ScientistWithPlanetsSerializer
    end

    def update
        scientist = find_scientist
        scientist.update!(scientist_params)
        render json:scientist, except: [:created_at, :updated_at], status: :accepted
    end

    def destroy
        scientist = find_scientist
        scientist.destroy
        head :no_content
    end

    private

    def find_scientist
        Scientist.find(params[:id])
    end

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end
end
