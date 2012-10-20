class UrlsController < ApplicationController
  
  # call add template basically
  def add

  end

  # list all of the URLS.  And I mean ALL of them
  def list
    @urls = Urls.all()
    p @urls
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
