class ProfilesController < ApplicationController
  # GET /profiles
  def index
  end

  # GET /profiles/:id
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # POST /profiles
  def create
    Profile.create(
      name: params[:name], age: params[:age], gender: params[:gender],
      phone_number: params[:phone_number], email: params[:email],
      location: params[:location], instruments: params[:instruments].downcase,
      genre: params[:genre], availability: params[:availability], 
      user_id: @current_user.id
    )
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
