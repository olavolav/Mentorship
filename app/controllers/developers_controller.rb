class DevelopersController < ApplicationController
  before_action :set_developer, only: [:show, :edit, :update, :destroy]
  after_action :reset_seniority_limit, only: [:create, :update, :destroy]

  # GET /developers
  # GET /developers.json
  def index
    @developers = Developer.order_by(name: 'asc')
  end

  # GET /developers/1
  # GET /developers/1.json
  def show
  end

  # GET /developers/new
  def new
    @developer = Developer.new
  end

  # GET /developers/1/edit
  def edit
  end

  # POST /developers
  # POST /developers.json
  def create
    @developer = Developer.new(developer_params)

    respond_to do |format|
      if @developer.save
        format.html { redirect_to @developer, notice: 'Developer was successfully created.' }
        format.json { render :show, status: :created, location: @developer }
      else
        format.html { render :new }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /developers/1
  # PATCH/PUT /developers/1.json
  def update
    respond_to do |format|
      if @developer.update(developer_params)
        format.html { redirect_to @developer, notice: 'Developer was successfully updated.' }
        format.json { render :show, status: :ok, location: @developer }
      else
        format.html { render :edit }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developers/1
  # DELETE /developers/1.json
  def destroy
    @developer.destroy
    respond_to do |format|
      format.html { redirect_to developers_url, notice: 'Developer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /developers/assignment
  def assignment
    developers = Developer.active
    @assignments = MentorshipAssigner.new(developers).perform
  end


  protected


  # Use callbacks to share common setup or constraints between actions.
  def set_developer
    @developer = Developer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def developer_params
    dev_params = params['developer']
    if dev_params['starting_date(1i)'] && dev_params['starting_date(2i)'] && dev_params['starting_date(3i)']
      dev_params['starting_date'] = Time.new(
        dev_params.delete('starting_date(1i)'),
        dev_params.delete('starting_date(2i)'),
        dev_params.delete('starting_date(3i)')
        )
    end

    params.require(:developer).permit(:name, :starting_date, :image_url, :active)
  end

  def reset_seniority_limit
    Developer.reset_seniority_limit
  end

end
