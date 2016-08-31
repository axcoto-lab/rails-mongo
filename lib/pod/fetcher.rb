require 'open-uri'
require 'csv'
require 'json'

module Pod
  class Fetcher
    URL = "https://github.com/ageitgey/all-podcasts-dataset/blob/master/b.tsv"
    WRANGLER_URL = "https://feedwrangler.net/api/v2/podcasts/popular"

    def self.sync!
      puts "Sync podcast"
      fetcher = self.new
      fetcher.fetch(WRANGLER_URL)
    end

    def request_csv(url)
      web_contents  = open(url) {|f| f.read }
      puts web_contents
      customers = CSV.parse(web_contents, { :col_sep => "\t" })
      customers
    end

    def request_json(url)
      contents = open(url) { |f| f.read }
      podcasts = JSON.parse(contents)["podcasts"]
      podcasts
    end

    def fetch(url)
      request_json(url).each do |p|
        Podcast.create({
          name: p["title"],
          url: p["feed_url"],
          image_url: p["image_url"],
        })
      end
    end

  end
end
