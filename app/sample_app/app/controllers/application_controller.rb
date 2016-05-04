class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #引入session控制器的帮助模块，默认情况下帮助函数只能在view中使用，手动引入后，就可以在控制器中使用。
  include SessionsHelper
end
