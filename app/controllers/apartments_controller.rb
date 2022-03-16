class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # GET /apartments
  def index
    render json: Apartment.all
  end

  # GET /apartments/1
  def show
    render json: find_apartment
  end

  # POST /apartments
  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  end

  # PATCH/PUT /apartments/1
  def update
    apartmnet = find_apartment
    apartment.update!(apartment_params)
    render json: apartment
  end

  # DELETE /apartments/1
  def destroy
    apartment = find_apartment
    apartment.destroy
    head :no_content
  end

  private
    def find_apartment
      Apartment.find(params[:id])
    end

    def apartment_params
      params.permit(:number)
    end

    def render_unprocessable_entity_response
      render json: { errors: invalid.record.errors }, status: :unprocessable
    end

    def render_not_found_response
      render json: { errors: "Tenant not found" }, status: :not_found
  end
end
