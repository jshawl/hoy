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
    @repo = Rugged::Repository.new( './public/' + params[:repo] +'.git')
    @tree = @repo.lookup( @repo.head.target )
  end

  def blob
    @repo = Rugged::Repository.new( './public/' + params[:repo] +'.git')
    @contents = Rugged::Blob.from_workdir @repo, params[:file]
    obj = @repo.lookup @contents
    robj = obj.read_raw
    @body  = robj.data
  end
end
