class ReposController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def index
    @repos = []
    Dir["/git/*"].each do | repo |
      sansgit = repo.gsub('.git','')
      @repos << File.basename(sansgit)
    end
  end

  def show
    repo = Rugged::Repository.new( '/git/' + params[:repo] +'.git')
    head = repo.head.target
    @tree = repo.lookup( head )
    p @tree
  end
end
