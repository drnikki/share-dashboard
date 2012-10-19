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
  
end
