class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:edit, :update, :destroy, :task_audits]

  def index
    @tasks = current_user.tasks.by_priority(params[:priority])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.turbo_stream do
          flash.now[:notice] = 'Task was successfully created.'
          render turbo_stream_response('create_success')
        end
      else
        format.turbo_stream do
          flash.now[:error] = 'Something went wrong.'
          render turbo_stream_response('create_error')
        end
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream do
          flash.now[:notice] = 'Task was successfully updated.'
          render turbo_stream_response('update_success')
        end
      else
        format.turbo_stream do
          flash.now[:error] = 'Something went wrong.'
          render turbo_stream_response('update_error')
        end
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = 'Task was successfully deleted.'
        render turbo_stream_response('destroy_success')
      end
    end
  end

  def task_audits
    @task_audits = @task.audits.where(action: 'update')
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :priority, :status)
  end

  def turbo_stream_response(action)
    [
      turbo_stream.replace('tasks_list', partial: 'tasks/tasks_list', locals: { tasks: current_user.tasks }),
      turbo_stream.update('flash', partial: 'shared/flash_messages'),
      turbo_stream.replace('task_activity', partial: 'layouts/footer',
        locals: { activity: current_user.today_task_activity })
    ].prepend(turbo_stream.replace("#{action}_task_frame", partial: 'tasks/form',
     locals: { task: @task, turbo_frame_name: "#{action}_task_frame", status: @task.status }))
     .yield_self { |response| { turbo_stream: response } }
  end
end
