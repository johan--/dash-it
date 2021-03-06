class TodosController < ApplicationController
  respond_to :html, :json

  def show
    @todo = Todo.find(params[:id])
    respond_with @todo
  end

  def index
    @todos = Todo.where(project_id: params[:project_id])
    respond_with @todos
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(params[:todo])

    respond_to do |format|
      if @todo.save
        format.json { render json: @todo, status: :created }
#        format.json { render json: @todo, status: :created, location: project_todo_path(@todo) }
      else
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @todo = Todo.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.json { render json: nil, status: :ok }
    end
  end
end
