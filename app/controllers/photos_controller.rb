class PhotosController < ApplicationController
    attr_reader :resource
    #before_filter :set_resource

  # GET /photos
  # GET /photos.json
  def index
    redirect_to resource_path 
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    redirect_to resource_path 
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
   # @photo = Photo.new
    #respond_to do |format|
    # format.html # new.html.erb
    #  format.json { render json: @photo }
    #end
  end

  # GET /photos/1/edit
  def edit
    #@photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
    
    photo = params[:photo]
  
    logger.debug(photo)
    if !photo.nil?
      new_photo_params = { "attachment" => photo, "photo_type_id" => Enum::OTHER}
      @photo = resource.photos.new(new_photo_params)
    end
    respond_to do |format|
      if @photo.save
        format.json { render json: {files: [@photo.to_jq_upload]}, status: :created, location: @photo }
      else
        
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = resource.photos.find(params[:id])
    

    respond_to do |format|
      if @photo.update_attributes(photo_params)
        format.json { head :no_content }
        logger.info("save photo")
        logger.info photo_params["photo_type_id"]
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity, notice: 'Error.' }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])

    if @photo.destroy
      head :no_content
    else
      render json: {photo: @photo.errors}, status: 422
    end
  end

  def photo_params
    return nil if params[:photo].blank?
    params.require(:photo).permit(
      :attachment,
      :lat,
      :lon
    )
  end

  def set_resource
    @resource ||= if params[:user_id].present?
      current_user
    end
  end


end
