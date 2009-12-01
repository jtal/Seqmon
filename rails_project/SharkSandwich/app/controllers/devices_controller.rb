class DevicesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def register_device
    @device = Device.find_by_token(params[:token])
    if (@device == nil) 
        @device = Device.new(:token=>params[:token])
    end

    respond_to do |format|
      if @device.save
        format.js  { render :json => {:token=>@device.token}, :status => :created};
      else
        format.js  { render :json => @device.errors, :status => :unprocessable_entity }
      end
    end
  end
end
