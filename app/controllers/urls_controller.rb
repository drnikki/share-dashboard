class UrlsController < ApplicationController
  FACEBOOK_URL      = 'http://api.ak.facebook.com/restserver.php?v=1.0&method=links.getStats&urls=%%URL%%&format=json'
  TWITTER_URL       = 'http://urls.api.twitter.com/1/urls/count.json?url=%%URL%%'
  REDDIT_URL        = 'http://buttons.reddit.com/button_info.json?url=%%URL%%'
  LINKEDIN_URL      = 'http://www.linkedin.com/cws/share-count?url=%%URL%%'
  DIGG_URL          = 'http://widgets.digg.com/buttons/count?url=%%URL%%'
  DELICIOUS_URL     = 'http://feeds.delicious.com/v2/json/urlinfo/data?url=%%URL%%'
  STUMBLEUPON_URL   = 'http://www.stumbleupon.com/services/1.01/badge.getinfo?url=%%URL%%'
  PINTEREST_URL     = 'http://api.pinterest.com/v1/urls/count.json?url=%%URL%%'


  def add
    
  end

  # Saves a new URL and directs user to its page
  def create
    # creates a new project
    p params[:urls]
    theurl = params[:urls]['address']
    # get the data for this one
    params[:urls]["delicious"] = delicious theurl
    params[:urls]["twitter"] = twitter theurl
    params[:urls]["stumbleupon"] = stumbleupon theurl
    params[:urls]["facebook"] = facebook theurl

    @urls = Urls.new(params[:urls]);
    @urls.save
    redirect_to :action => :show, :id => @urls.id
  end

  # Shows specific URL
  def show
    @urls = Urls.find(params[:id])
  end

  # WET Twitter data getter
  def twitter url
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
  def facebook url

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
  def stumbleupon url
    aurl = STUMBLEUPON_URL.gsub("%%URL%%", url)
    opened = open(aurl)
    jsonobj = ActiveSupport::JSON.decode(opened)
    p jsonobj['result']['views']
    return jsonobj['result']['views']
  end

  # and finally, WET AS SHIT delicious data getter
  def delicious url
    aurl = DELICIOUS_URL.gsub("%%URL%%", url)
    opened = open(aurl)
    jsonobj = ActiveSupport::JSON.decode(opened)
    p jsonobj[0]['total_posts']
    # @todo - if for zero when it's null.
    return jsonobj[0]['total_posts']
  end

end
# ----------------- note
# {"count"=>11311, "url"=>"http://rapgenius.com/"}
# {"count"=>4, "url"=>"http://www.rapgenius.com/"}
