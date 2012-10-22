class Urls
  include Mongoid::Document

  field :address, type: String
  field :project, type: String
  #@todo, make the relationships if project stays
  field :facebook, type: Integer
  field :twitter, type: Integer
  field :reddit, type: Integer
  field :linkedin, type: Integer
  field :digg, type: Integer
  field :delicious, type: Integer
  field :stumbleupon, type: Integer
  field :pinterest, type: Integer
  field :gplus, type: Integer
  field :updated, type: DateTime
  
  FACEBOOK_URL      = 'http://api.ak.facebook.com/restserver.php?v=1.0&method=links.getStats&urls=%%URL%%&format=json'
  TWITTER_URL       = 'http://urls.api.twitter.com/1/urls/count.json?url=%%URL%%'
  REDDIT_URL        = 'http://buttons.reddit.com/button_info.json?url=%%URL%%'
  LINKEDIN_URL      = 'http://www.linkedin.com/cws/share-count?url=%%URL%%'
  DIGG_URL          = 'http://widgets.digg.com/buttons/count?url=%%URL%%'
  DELICIOUS_URL     = 'http://feeds.delicious.com/v2/json/urlinfo/data?url=%%URL%%'
  STUMBLEUPON_URL   = 'http://www.stumbleupon.com/services/1.01/badge.getinfo?url=%%URL%%'
  PINTEREST_URL     = 'http://api.pinterest.com/v1/urls/count.json?url=%%URL%%'

  # get the share data when a new one is being created
  def self.get_share_data theurl

  	require 'open-uri'
  
    # creates a new project
    #p params[:urls]
    #theurl = params[:urls]['address']
    # get the data for this one
    params = Hash.new
    
    params["delicious"] = delicious theurl
    params["twitter"] = twitter theurl
    params["stumbleupon"] = stumbleupon theurl
    params["facebook"] = facebook theurl
    params["updated"] = Time.now.to_s
	
	return params
  end
  
  
  
  
  
  
  # WET Twitter data getter
  def self.twitter url
    aurl = TWITTER_URL.gsub("%%URL%%", url)
    opened = open(aurl).read
    jsonobj = ActiveSupport::JSON.decode(opened)
    # [{"url"=>"http://rapgenius.com", "normalized_url"=>"http://www.rapgenius.com/", "share_count"=>8525, "like_count"=>3995, "comment_count"=>5884, "total_count"=>18404, "click_count"=>3, "comments_fbid"=>10150415949665424, "commentsbox_count"=>0}]
    #p 'in twitter fn'
    #p jsonobj
    p jsonobj['count']
    return jsonobj['count']
  end

  # WET Facebook data getter
  def self.facebook url

    #aurl = 'http://api.ak.facebook.com/restserver.php?v=1.0&method=links.getStats&urls=http://rapgenius.com&format=json'
    aurl = FACEBOOK_URL.gsub("%%URL%%", url)
    opened = open(aurl).read
    jsonobj = ActiveSupport::JSON.decode(opened)
    # [{"url"=>"http://rapgenius.com", "normalized_url"=>"http://www.rapgenius.com/", "share_count"=>8525, "like_count"=>3995, "comment_count"=>5884, "total_count"=>18404, "click_count"=>3, "comments_fbid"=>10150415949665424, "commentsbox_count"=>0}]

    #p jsonobj
    p jsonobj[0]['share_count']
    p jsonobj[0]['like_count']
    p jsonobj[0]['comment_count']
    p jsonobj[0]['click_count']
    p jsonobj[0]['total_count']

    return jsonobj[0]['share_count']
  end

  # WET Stumbelupon data getter
  def self.stumbleupon url
    aurl = STUMBLEUPON_URL.gsub("%%URL%%", url)
    opened = open(aurl)
    jsonobj = ActiveSupport::JSON.decode(opened)
    p jsonobj['result']['views']
    return jsonobj['result']['views']
  end

  # and finally, WET AS SHIT delicious data getter
  def self.delicious url
    aurl = DELICIOUS_URL.gsub("%%URL%%", url)
    opened = open(aurl)
    jsonobj = ActiveSupport::JSON.decode(opened)
    p jsonobj[0]['total_posts']
    # @todo - if for zero when it's null.
    return jsonobj[0]['total_posts']
  end

  
  
  
end
