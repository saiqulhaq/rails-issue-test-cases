class DevicesController < ApplicationController
    def create_or_find
        render json: { value: true }
    end

    def status 
        render json: Device.count
    end
     
    # post :create_or_find 
    # post :find_or_create
end