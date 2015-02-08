class ProjectsController < ApplicationController
  
  def index
    
    if session[:user_id].nil?

      redirect_to '/'

    else

      @projects = Todo.select("todo_project, max(todo_deadline) as project_deadline, sum(if(todo_complete is null,1,0)) as todo_item_count, sum(if(todo_complete=true,0,todo_timeremaining)) as time_remaining, 100-round(sum(if(todo_complete=true,0,todo_timeremaining))*100/sum(todo_timerequired),0) as percentage_complete").where("todo_project is not null and todo_project !='' AND sum(if(todo_complete = true,0,1))>0	 AND user_id = ?", session[:user_id]).group("todo_project")
      @new_todo = Todo.new
      render :index

    end

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

    redirect_to :back

  end

  def projectdetails
    
    @project_todos = Todo.where("todo_project = ? AND user_id = ?", params[:project],session[:user_id]).order("todo_deadline ASC, todo_item ASC")
    @new_todo = Todo.new

    if @project_todos.count == 0

      flash[:error]="Invalid Project"
      redirect_to projects_path

    else

      render :details

    end

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
      flash[:success] = "To Do Details Updated"
    end
    redirect_to :back

  end

  def updateurgence
    Todo.update_all todo_urgence: ("10/((todo_deadline - curdate()) - todo_timeremaining/8)")
    Todo.where("todo_urgence < 0").update_all todo_urgence: 11
    Todo.where("todo_complete is true AND todo_deadline < curdate()").update_all todo_urgence: 0

    redirect_to index_path
  end
end
