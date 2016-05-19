class MusiciansController < ApplicationController
  before_action :set_musician, only: [:show, :edit, :update, :destroy]

  # GET /musicians(.json)
  def index
    @musicians = User.all
  end

  # GET /musicians/1(.json)
  def show
  end

  # GET /musicians/new
  def new
    @musician = User.new
  end

  # GET /musicians/1/edit
  def edit
  end

  # POST /musicians(.json)
  def create
    @musician = User.new user_params

    respond_to do |format|
      if @musician.save
        format.html { redirect_to @musician, notice: 'Musician created.' }
        format.json { render :show, status: :created, location: @musician }
      else
        format.html { render :new }
        format.json { render json: @musician.errors, 
                             status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /musicians/1(.json)
  def update
    respond_to do |format|
      if @musician.update user_params
        format.html { redirect_to @musician, notice: 'Musician updated.' }
        format.json { render :show, status: :ok, location: @musician }
      else
        format.html { render :edit }
        format.json { render json: @musician.errors, 
                             status: :unprocessable_entity }
      end
    end
  end

  # DELETE /musicians/1(.json)
  def destroy
    @musician.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Musician deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def set_musician
    @musician = User.find params[:id]
  end

  def user_params
    params.fetch :user, {}
  end
end
