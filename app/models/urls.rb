class Urls
  include Mongoid::Document

  field :address, type: String
  field :project, type: String
  #@todo, make the relationships if project stays
  field :facebook, type: Numeric
  field :twitter, type: Numeric
  field :reddit, type: Numeric
  field :linkedin, type: Numeric
  field :digg, type: Numeric
  field :delicious, type: Numeric
  field :stumbleupon, type: Numeric
  field :pinterest, type: Numeric
  field :gplus, type: Numeric
  
end
