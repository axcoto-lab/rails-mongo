namespace :pod_fetcher do
  desc "Download podcast"
  task sync: :environment do
    Pod::Fetcher.sync!
  end

end
