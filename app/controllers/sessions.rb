require_relative '../models/user'

class SessionController < BaseController
  def new
    render 'new_session.html'
  end

  def create
    user = User.find_by(email: params['email'], password: params['password'])
    if user
      set_session('id', user.id)
      set_session('name', user.name)
      redirect_to '/'
    else
      set_cookie('errors', 'message', 'User not found')
      redirect_to '/sign_in'
    end
  end

  def delete
    return render json: '{}', status: 404 unless current_user

    cookies['_session_id'] = {}
    render json: '{}'
  end
end
###################################################################################
#                   Posible code improvements and fixes                           #                                                                               
###################################################################################
#                                                                                 #
# user = User.find_by(email: params['email'], password: params['password'])       #
#    if user                                                                      #
#     cookies.signed[:secure_session] = user.id                                   # 
#     cookies.signed[:secure_session] = user.name                                 #
#      set_session('id', cookies.signed[:secure_session])                         #
#     set_session('name', cookies.signed[:secure_session])                        #
#      redirect_to '/'                                                            #
###################################################################################

###################################################################################
#Using the cookie.signed() method encrypts the cookie value                       #                                                                               
###################################################################################
