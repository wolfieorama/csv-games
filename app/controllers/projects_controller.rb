class ProjectsController < InheritedResources::Base
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @project = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfuly saved. '}
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update
        format.html { redirect_to @project, notice: 'Project was successfuly saved. '}
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.destroy(project_params)
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, tasks_attributes: [:id, :description, :done, :_destroy])
    end
end
