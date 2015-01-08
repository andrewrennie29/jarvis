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
    t.todo_category = params[:todo][:todo_category]
    t.todo_project = params[:todo][:todo_project]
    t.todo_timerequired = params[:todo][:todo_timerequired].to_s.to_f
    t.todo_importance = params[:todo][:todo_importance].to_i

    if params[:todo][:todo_status].nil?
      t.todo_status = 0  
    else
      t.todo_status = (params[:todo][:todo_status].delete('%').to_f)/100
    end

    if ((params[:todo][:todo_deadline]).to_i).to_s == (params[:todo][:todo_deadline]).to_s

      t.todo_deadline = ((params[:todo][:todo_deadline]).to_s + '18:00:00').to_f

    else

     t.todo_deadline=params[:todo][:todo_deadline]

    end

    t.todo_recurring=params[:todo][:todo_recurring]
    
    if t.todo_recurring

      t.todo_frequency=params[:todo][:todo_frequency]
      
      frequencymultiplier = case t.todo_frequency
        when 'Daily' then 1
        when 'Week Days' then 1
	when 'Weekly' then 7
        when 'Fortnightly' then 14
        when 'Monthly' then 28
        when 'Yearly' then 365
      end

      if (params[:todo][:todo_enddate]).to_i.to_s == (params[:todo][:todo_enddate]).to_s

        t.todo_enddate=(t.todo_deadline.to_i + ((frequencymultiplier * (params[:todo][:todo_enddate]).to_i)-1).to_i).to_i

      else

        t.todo_enddate=params[:todo][:todo_enddate]

      end

    end

    t.todo_timeremaining=(1-t.todo_status)*t.todo_timerequired
    
    t.save
    unless t.valid?
      flash[:error] = t.errors.full_messages.join("<br>").html_safe
    else
      flash[:success] = "Todo added successfully"
    end
    redirect_to index_path

  end

end