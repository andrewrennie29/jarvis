class TodosController < ApplicationController
  
  def index
    
    Todo.connection.execute("UPDATE todos set todos.todo_urgence = 10/((todos.todo_deadline - curdate()) - todos.todo_timeremaining/8) WHERE todos.todo_complete = false")
    Todo.where("todo_urgence < 0").update_all todo_urgence: 11
    Todo.where("todo_complete is true AND todo_deadline < curdate()").update_all todo_urgence: 0
    @todo_items = Todo.where("user_id = ?", session[:user_id])
    @new_todo = Todo.new
    @todo_today = @todo_items.where("todos.todo_category<>'Personal' and (todo_urgence >= 11 OR todo_deadline = curdate())").order("todo_complete ASC, (todo_urgence + todo_importance) DESC, todo_item ASC")
    @todo_tomorrow = @todo_items.where("todos.todo_category<>'Personal' and todos.todo_deadline = curdate()+1")
    @todo_week = @todo_items.where("todos.todo_category<>'Personal' and todos.todo_deadline > curdate() and todos.todo_deadline < ADDDATE(SUBDATE(curdate(), interval DAYOFWEEK(CURDATE()) - 1 DAY), INTERVAL 1 WEEK)")
    @todo_personal = @todo_items.where("todos.todo_category='Personal' and (todos.todo_complete = false or todos.updated_at>=curdate()-1)").order("todo_complete ASC, todo_item ASC")
    render :index

  end

  def add

    todo = Todo.create(:todo_item => params[:todo][:todo_item], :user_id => session[:user_id])
    unless todo.valid?
      flash[:error] = todo.errors.full_messages.join("<br>").html_safe
    else
      flash[:success] = "Todo added successfully"
    end
    redirect_to details_path(todo.id)

  end

  def delete

    t=Todo.last
    if !t.nil? 
      t.delete
    end

  end

  def complete

    if params['complete_todo']

      params[:todos_checkbox].each do |check|

        todo_id = check

        t=Todo.find_by_id(todo_id)

	if t.todo_recurring and !t.todo_complete
	
	  recur=Todo.new
	  recur.todo_item=t.todo_item
	  recur.todo_for=t.todo_for
	  recur.todo_category=t.todo_category
	  recur.todo_project=t.todo_project
	  recur.todo_timerequired=t.todo_timerequired
	  recur.todo_importance=t.todo_importance
	  recur.todo_status = 0
	  recur.todo_recurring=t.todo_recurring
	  recur.todo_frequency=t.todo_frequency
	  recur.todo_enddate=t.todo_enddate
	  recur.todo_deadline = case t.todo_frequency
            when 'Daily'       then (t.todo_deadline).to_time.advance(:days => 1).to_date
            when 'Week Days'   then (t.todo_deadline).to_time.advance(:days => 1).to_date
	    when 'Weekly'      then (t.todo_deadline).to_time.advance(:weeks => 1).to_date
            when 'Fortnightly' then (t.todo_deadline).to_time.advance(:weeks => 2).to_date
            when 'Monthly'     then (t.todo_deadline).to_time.advance(:months => 1).to_date
            when 'Yearly'      then (t.todo_deadline).to_time.advance(:years => 1).to_date
          end
          recur.todo_timeremaining = (1-recur.todo_status)*recur.todo_timerequired
	  if !recur.todo_enddate.nil? and recur.todo_enddate > recur.todo_deadline
            recur.save
          end
	
	end

        t.todo_complete = !t.todo_complete

        t.save

      end
    
    end

    if params['delete_todo']

      params[:todos_checkbox].each do |check|

        todo_id = check

        t=Todo.find_by_id(todo_id)

	t.delete

      end
    
    end

    redirect_to index_path

  end

  def details
  
    @details_todo = Todo.find_by_id(params[:id]).where('user_id=?' session[:user_id])

    render :details

  end

  def updatetodo

    t = Todo.find_by_id(params[:todo][:todo_id])
    t.todo_item = params[:todo][:todo_item]
    t.todo_for = params[:todo][:todo_for]
    t.todo_category = params[:todo][:todo_category]
    t.todo_project = params[:todo][:todo_project]
    t.todo_timerequired = params[:todo][:todo_timerequired]
    t.todo_importance = params[:todo][:todo_importance]

    if params[:todo][:todo_status].nil?
      t.todo_status = 0  
    else
      t.todo_status = (params[:todo][:todo_status].delete('%').to_f)/100
    end

    t.todo_deadline = params[:todo][:todo_deadline]

    t.todo_recurring=params[:todo][:todo_recurring]
    
    if t.todo_recurring

      t.todo_frequency=params[:todo][:todo_frequency]

      if (params[:todo][:todo_enddate]).to_i.to_s == (params[:todo][:todo_enddate]).to_s

        t.todo_enddate = case t.todo_frequency
          when 'Daily'       then (t.todo_deadline).to_time.advance(:days => (params[:todo][:todo_enddate]).to_i).to_date
          when 'Week Days'   then (t.todo_deadline).to_time.advance(:days => (params[:todo][:todo_enddate]).to_i).to_date
	  when 'Weekly'      then (t.todo_deadline).to_time.advance(:weeks => (params[:todo][:todo_enddate]).to_i).to_date
          when 'Fortnightly' then (t.todo_deadline).to_time.advance(:weeks => (params[:todo][:todo_enddate]).to_i*2).to_date
          when 'Monthly'     then (t.todo_deadline).to_time.advance(:months => (params[:todo][:todo_enddate]).to_i).to_date
          when 'Yearly'      then (t.todo_deadline).to_time.advance(:years => (params[:todo][:todo_enddate]).to_i).to_date
        end

      else

        t.todo_enddate=params[:todo][:todo_enddate]

      end

    end

    t.todo_timeremaining=(1-t.todo_status)*t.todo_timerequired

    t.todo_urgence=(10/((t.todo_deadline - Date.today).to_f - t.todo_timeremaining/8)).to_f

    if t.todo_urgence < 0

     t.todo_urgence=11

    end

    t.save
    unless t.valid?
      flash[:error] = t.errors.full_messages.join("<br>").html_safe
    else
      flash[:success] = "Todo added successfully"
    end
    redirect_to index_path

  end

  def updateurgence
    Todo.update_all todo_urgence: ("10/((todo_deadline - curdate()) - todo_timeremaining/8)")
    Todo.where("todo_urgence < 0").update_all todo_urgence: 11
    Todo.where("todo_complete is true AND todo_deadline < curdate()").update_all todo_urgence: 0

    redirect_to index_path
  end
end
