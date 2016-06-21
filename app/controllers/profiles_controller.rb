class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_profile, only: [:show, :hide, :edit, :update, :destroy]

  # GET /profiles
  def index
    @profiles = Profile.all
    profiles = []
    if params[:name]
      @profiles.each do |p| 
        if p.name.include? params[:name]
          profiles << p
        end
      end
    end
    if params[:age]
      @profiles.each do |p|
        unless profiles.include?(p) || p.age != params[:age]
          profiles << p
        end
      end
    end
    if params[:location]
      @profiles.each do |p|
        unless profiles.include?(p) || !p.location.include?(params[:location])
          profiles << p
        end
      end
    end
    if params[:genres]
      @profiles.each do |p|
        unless profiles.include?(p) || !p.genres.include?(params[:genres])
          profiles << p
        end
      end
    end
    if params[:availability]
      days = params[:availability].downcase.split(',').map! &:strip  
      @profiles.each do |p|
        unless profiles.include? p
          days.each do |day| 
            if p.include? day
              profiles << p
              break
            end
          end
        end
      end
    end
    @profs = profiles
  end

  # GET /profiles/:id
  def show
    redirect_to '/profiles/unshow' unless signed_in?

    if signed_in? && @profile.user != current_user
      redirect_to "/profiles/#{params[:id]}/hide" 
    end

    if signed_in? && @profile.user == current_user
      redirect_to "/profiles/#{params[:id]}/edit"
    end
  end

  # GET /profiles/hide
  def hide
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # POST /profiles
  def create
    @profile = Profile.new       user_id: current_user.id, 
      name: params[:name],       age: params[:age], 
      gender: params[:gender],   phone_number: params[:phone_number], 
      email: params[:email],     location: params[:location], 
      privacy: params[:privacy], genre: params[:genre], 
      availability: params[:availability],
      instruments: params[:instruments].downcase
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
    post_params = {            user_id: current_user.id,            
      name: params[:name],     age: params[:age],          
      gender: params[:gender], phone_number: params[:phone_number],
      email: params[:email],   genre: params[:genre],
      availability: params[:availability], 
      instruments: params[:instruments].downcase }
    respond_to do |format|
      if @profile.update post_params
        format.html { redirect_to @post, notice: 'Profile updated!' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  # GET /profiles/:id/settings
  def settings
  end

  # DELETE /profiles/:id
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was destroyed!' }
      format.json { head :no_content }
    end
  end

  private

  def set_profile
    @profile = Profile.find params[:id]
  end

  def profile_params
    params.fetch :profile, {}
  end
end
