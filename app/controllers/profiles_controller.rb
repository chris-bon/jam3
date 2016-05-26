class ProfilesController < ApplicationController
  # GET /profiles
  def index
  end

  # GET /profiles/:id
  def show
  end

  # GET /profiles/new
  def new
    flash[:success] = 'New user registered!' if user_signed_in?
    @profile = Profile.new
  end

  # POST /profiles
  def create
    new_profile = Profile.create(
      name: params[:name], age: params[:age], gender: params[:gender],
      phone_number: params[:phone_number], email: params[:email],
      location: params[:location], instruments: params[:instruments].downcase,
      genre: params[:genre], availability: params[:availability], 
      user_id: current_user.id
    )
    User.find_by(current_user.id).update(profile_id: new_profile.id)
    redirect_to root_path
  end

  # GET /profiles/:id/edit
  def edit
  end

  # PATCH /profiles/:id
  def update
  end

  # DELETE /profiles/:id
  def destroy
  end
end
