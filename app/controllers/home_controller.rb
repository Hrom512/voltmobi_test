class HomeController < ApplicationController
  def index
    @tasks = Task.includes(:user)
  end
end
