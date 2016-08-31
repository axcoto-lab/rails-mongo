class Podcast
  include Mongoid::Document
  field :name, type: String
  field :url, type: String
  field :image_url, type: String

end
