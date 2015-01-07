class TodosController < ApplicationController
  
  def index
  
    @todo_items = Todo.all
    @new_todo = Todo.new
    
    render :index

  end

  def add

    todo = Todo.create(:todo_item => params[:todo][:todo_item])
    unless todo.valid?
      flash[:error] = todo.errors.full_messages.join("<br>").html_safe
    else
      flash[:success] = "Todo added successfully"
    end
    redirect_to details_path

  end

  def delete

    t=Todo.last
    if !t.nil? 
      t.delete
    end

  end

  def complete

    params[:todos_checkbox].each do |check|

      todo_id = check

      t=Todo.find_by_id(todo_id)

      t.todo_complete= !t.todo_complete

      t.save

    end
    
    redirect_to index_path

  end

  def details
  
    @details_todo = Todo.last

    render :details

  end

  def updatetodo

    t = Todo.last
    t.todo_for = params[:todo][:todo_for]
    t.save
    unless t.valid?
      flash[:error] = t.errors.full_messages.join("<br>").html_safe
    else
      flash[:success] = "Todo added successfully"
    end
    redirect_to index_path

  end

end