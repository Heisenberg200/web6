require_relative 'home'
require_relative '../models/todo'

class TodosController < HomeController
  def sync
    params["data"].each do |todo|
      record = Todo.find_by(id: todo["id"])
      if record
        record.assign_attributes(todo)
        record.save
      else
        Todo.create(todo)
      end
    end

    todos = Todo.where("user_id = #{params['user_id']}")
    render json: JSON.dump(todos.as_json)
  end
end
###################################################################################
#                   Posible code improvements and fixes                           #                                                                               
###################################################################################
#                                                                                 #
# todos = Todo.where("user_id = #{params['user_id'].to_value}")                   #
###################################################################################
###################################################################################
# Here in order to avoid the SQL injection we are casting the user_id             #
# parameter to an expected value, avoiding the SQL injection                      #
###################################################################################
###################################################################################
# Aother possible fix is is by using positional handlers to sanitize tained str-  #
# ings as in the example:                                                         #
# todos = Todo.where("zip_code = ? AND quantity >= ?", entered_zip_code,          #
# entered_zip_quantity).first                                                     #
# In such case the first parameter is a SQL fragment with qwestion mark, and the  #
# second and third parameter will replacethe question marks with the value of     #
# variables.                                                                      #
###################################################################################  
    