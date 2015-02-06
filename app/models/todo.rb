class Todo < ActiveRecord::Base
  
  validates :todo_item, presence: true

def self.allowview(todo_id, session_user_id)

  t=Todo.find_by_id(todo_id)

  if t.user_id == session_user_id

    todo_id

  else

    nil

  end

end

end
