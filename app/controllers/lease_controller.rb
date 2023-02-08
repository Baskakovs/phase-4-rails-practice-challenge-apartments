class LeaseController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_entry_error

    def create
        lease = Lease.create!(tenant_id: params[:tenant_id], apartment_id: params[:apartment_id], rent: params[:rent])
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    private 

    def render_not_found_response
        render json: { error: "Lease not found" }, status: :not_found
    end

    def render_invalid_record_entry_error(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
