class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  def index
    @profiles = Profile.all
  end

  # GET /profiles/:id
  def show
    @profile = Profile.find params[:id]
  end

  # GET /profiles/new
  def new
    if Profile.find current_user.id
      redirect_to profile_path
    else
      @profile = Profile.new
    end
  end

  # POST /profiles
  def create
    @profile = Profile.new    name: params[:name],      
                               age: params[:age],   
                            gender: params[:gender],  
                      phone_number: params[:phone_number], 
                             email: params[:email],
                          location: params[:location],
                       instruments: params[:instruments].downcase,
                             genre: params[:genre],
                      availability: params[:availability], 
                           user_id: current_user.id 
    current_user.update profile_id: @profile.id
    respond_to do |format|
      if @profile.save
        format.html { redirect_to root_path, notice: 'New profile created!' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, 
                             status: :unprocessable_entity }
      end
    end
  end

  # GET /profiles/:id/edit
  def edit
  end

  # PATCH /profiles/:id
  def update
  end

  # GET /profiles/:id/settings
  def settings
  end

  # DELETE /profiles/:id
  def destroy
  end

  private

  def set_profile
    @profile = Profile.find params[:id]
  end

  def profile_params
    params.fetch :profile, {}
  end
end
