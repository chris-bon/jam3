class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_profile, only: [:settings, :show, :hide, :edit, :update, 
                                     :destroy]

  # GET /profiles
  def index
    # if params[:name]
    #   @profiles = Profile.search_names(params[:name])
    # end
    
    # search_results = []
    # Profile.all.each do |profile|
    #   if params[:name] && profile.name.include?(params[:name])
    #     search_results << profile
    #   elsif params[:age] && profile.age == params[:age]
    #       search_results << profile
    #   elsif params[:location] && 
    #         profile.location.city.include?(params[:location])
    #     search_results << profile
    #   elsif params[:genre] && profile.genre.include?(params[:genre])
    #     search_results << profile
    #   elsif params[:availability]
    #     params[:availability].downcase!
    #     if params[:availability].include?(',')
    #       days = params[:availability].downcase.split(',').map!(&:strip)
    #       has_day = false
    #       days.each do |day| 
    #         has_day = true if profile.availability.include?(day)
    #       end
    #       search_results << profile if has_day
    #     elsif params[:availabilty].include? ' '
    #       days = params[:availability].downcase.split(' ').map!(&:strip)
    #       has_day = false
    #       days.each do |day| 
    #         has_day = true if profile.availability.include?(day)
    #       end
    #       search_results << profile if has_day
    #     else
    #       if profile.availability.include?(params[:availability])
    #         search_results << profile
    #       end
    #     end
    #   end
    # end
    @profiles = Profile.all
  end

  # GET /profiles/:id
  def show
    if @profile.user == current_user
      redirect_to edit_profile_path(@profile)
    elsif @profile.hide
      redirect_to hide_profile_path(@profile)
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
    @profile = Profile.new image_url: params[:image_url], name: params[:name],
                           age: params[:age], gender: params[:gender],
                           phone_number: params[:phone_number],
                           instruments: params[:instruments],
                           genre: params[:genre], hide: params[:hide],
                           availability: params[:availability]
    Location.create! profile_id: @profile.id
    if @profile.save
      flash[:success] = 'New Profile Created!' 
      redirect_to root_path
    else
      flash[:warning] = 'Profile has not been updated!'
      redirect_to edit_profile_path
    end
  end

  # GET /profiles/:id/edit
  def edit
  end

  # PATCH /profiles/:id
  def update
    @profile.user.update username: params[:username]
    @profile.location.update city: params[:location]
    if @profile.update image_url: params[:image_url], name: params[:name],
                       age: params[:age], gender: params[:gender],
                       phone_number: params[:phone_number],
                       instruments: params[:instruments],
                       genre: params[:genre], hide: params[:hide],
                       availability: params[:availability]
      flash[:success] = 'Profile has been updated!'
      redirect_to root_path
    else
      flash[:warning] = 'Profile has not been updated!'
      redirect_to edit_profile_path(@profile)
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
    params.fetch :location, {}
  end
end
