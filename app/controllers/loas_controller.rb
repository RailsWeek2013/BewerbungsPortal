class LoasController < ApplicationController
  before_action :set_loa, only: [:show, :edit, :update, :destroy]

  # GET /loas
  # GET /loas.json
  def index
    if(current_user.profile.nil?)
      redirect_to new_profile_path,
                  notice: "You need first to fill your profile ;)."
    else
          @loas = current_user.profile.loa
    end
  end

  # GET /loas/1
  # GET /loas/1.json
  def show
  end

  # GET /loas/new
  def new
    @loa = Loa.new
  end

  # GET /loas/1/edit
  def edit
  end

  # POST /loas
  # POST /loas.json
  def create
    @loa = Loa.new(loa_params)
    @loa.profile = current_user.profile

    respond_to do |format|
      if @loa.save
        format.html { redirect_to @loa, notice: 'Letter of Applicaton was successfully created.' }
        format.json { render action: 'show', status: :created, location: @loa }
      else
        format.html { render action: 'new' }
        format.json { render json: @loa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loas/1
  # PATCH/PUT /loas/1.json
  def update
    respond_to do |format|
      if @loa.update(loa_params)
        format.html { redirect_to @loa, notice: 'Letter of Applicaton was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @loa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loas/1
  # DELETE /loas/1.json
  def destroy
    @loa.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Letter of Applicaton was successfully updated.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loa
      @loa = Loa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loa_params
      params.require(:loa).permit(:to, :street, :city, :zip, :subject, :what)
    end
end
