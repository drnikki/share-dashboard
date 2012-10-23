class UrlsController < ApplicationController
  
  # call add template basically
  def add

  end

  # list all of the URLS.  And I mean ALL of them
  def list
    ## perform a paginated query:
    # @posts = Post.paginate(:page => params[:page])

    # or, use an explicit "per page" limit:
    # Post.paginate(:page => params[:page], :per_page => 30)

    @urls = Urls.all().paginate(:page => params[:page], :per_page => 1)
  end
  
  # little tester for resque when my db is pretty empty
  def refresh
    Urls.all.each do |record|
      data = Urls.get_share_data record.address
      # comes back as an array, goes right in.
      record.update_attributes(data)
    end

    redirect_to :action => :list
  end

  # @todo placeholder. urls all f'd up as requirements change.
  def force_refresh 
    p params[:id]
    puts 'forcing'
    #require 'resque'
    # todo fix this.
    #require_relative '../jobs/ProjectRefresher'
    #Resque.enqueue(ProjectRefresher)
    redirect_to :action => :list
  end

  # Saves a new URL and directs user to its page
  def create
  	require 'open-uri'	
  	theurl = params[:urls]['address']
  	
  	data = Urls.get_share_data theurl
  	data = data.merge(params[:urls])
    @urls = Urls.new(data)
    @urls.save
    redirect_to :action => :show, :id => @urls.id
  end

  # Shows specific URL
  def show
    @urls = Urls.find(params[:id])
  end

end


# ----------------- note: www matters.
# {"count"=>11311, "url"=>"http://rapgenius.com/"}
# {"count"=>4, "url"=>"http://www.rapgenius.com/"}
