class DeviceBlocksController < ApplicationController
  before_filter :fetch_device
  def fetch_device
    @device = Device.find params[:device_id]
  end
  private :fetch_device
  
  # GET /devices/1/blocks
  # GET /devices/1/blocks.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @devices }
    end
  end

  # GET /devices/1/blocks/new
  # GET /devices/1/blocks/new.json
  def new
    @device = Device.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @device }
    end
  end

  # GET /devices/1/blocks/edit
  def edit
    @device = Device.find(params[:id])
  end

  # POST /devices/1/blocks
  # POST /devices/1/blocks.json
  def create
    @device = Device.new(params[:device])

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device block was successfully created.' }
        format.json { render json: @device, status: :created, location: @device }
      else
        format.html { render action: "new" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /devices/1/blocks/1
  # PUT /devices/1/blocks/1.json
  def update
    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to @device, notice: 'Device block was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    respond_to do |format|
      format.html { redirect_to device_blocks_url }
      format.json { head :no_content }
    end
  end
end
