class ApartmentController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_entry_error

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment
    end

    def create
        apartment = Apartment.create!(number: params[:number])
        render json: apartment, status: :created
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(number: params[:number])
        render json: apartment, status: :accepted
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.leases.destroy_all
        apartment.destroy
        head :no_content
    end

    private 
    
    def render_not_found_response
        render json: { error: "Apartment not found" }, status: :not_found
    end

    def render_invalid_record_entry_error(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

end
