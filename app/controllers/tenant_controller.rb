class TenantController < ApplicationController
    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def create
        tenant = Tenant.create!(name: params[:name], age: params[:age])
        render json: tenant, status: :created
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update!(name: params[:name], age: params[:age])
        render json: tenant, status: :accepted
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.leases.destroy_all
        tenant.destroy
        head :no_content
    end

    private 
    
    def render_not_found_response
        render json: { error: "Tenant not found" }, status: :not_found
    end

    def render_invalid_record_entry_error(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
