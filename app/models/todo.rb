class Todo < ActiveRecord::Base
  
  validates :todo_item, presence: true

def self.allowview(todo_id, session_user_id)

  t=Todo.find_by_id(todo_id)
  c=Todo.where('id = ?', todo_id).count
  
  if c == 0

    nil

  else

    if t.user_id != session_user_id || 

      nil

    else

      todo_id

    end
  
  end

end

end
