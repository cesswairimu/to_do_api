class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  #called before action in controller
  before_action :authorize_request
  attr_reader :current_user

  private

  #check for a valid request and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end

