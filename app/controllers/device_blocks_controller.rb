class DeviceBlocksController < ApplicationController
  # GET /device_blocks
  # GET /device_blocks.json
  def index
    @device_blocks = DeviceBlock.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @device_blocks }
    end
  end

  # GET /device_blocks/1
  # GET /device_blocks/1.json
  def show
    @device_block = DeviceBlock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @device_block }
    end
  end

  # GET /device_blocks/new
  # GET /device_blocks/new.json
  def new
    @device_block = DeviceBlock.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @device_block }
    end
  end

  # GET /device_blocks/1/edit
  def edit
    @device_block = DeviceBlock.find(params[:id])
  end

  # POST /device_blocks
  # POST /device_blocks.json
  def create
    @device_block = DeviceBlock.new(params[:device_block])

    respond_to do |format|
      if @device_block.save
        format.html { redirect_to @device_block, notice: 'Device block was successfully created.' }
        format.json { render json: @device_block, status: :created, location: @device_block }
      else
        format.html { render action: "new" }
        format.json { render json: @device_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /device_blocks/1
  # PUT /device_blocks/1.json
  def update
    @device_block = DeviceBlock.find(params[:id])

    respond_to do |format|
      if @device_block.update_attributes(params[:device_block])
        format.html { redirect_to @device_block, notice: 'Device block was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @device_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_blocks/1
  # DELETE /device_blocks/1.json
  def destroy
    @device_block = DeviceBlock.find(params[:id])
    @device_block.destroy

    respond_to do |format|
      format.html { redirect_to device_blocks_url }
      format.json { head :no_content }
    end
  end
end
