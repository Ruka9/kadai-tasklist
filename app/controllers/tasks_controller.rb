class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @tasks = Task.all.page(params[:page]).per(10)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build
    
    if @task.save
      flash[:success] = "タスクが正常に作成されました"
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = "タスクが正常に作成されませんでした"
      render 'toppages/index'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = "タスクは正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクは正常に更新されませんでした"
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to root_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:status, :content)
  end
end
