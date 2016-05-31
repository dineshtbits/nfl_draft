require 'csv'

namespace :import do
  desc 'Import Draft data '
  task draft: :environment do
    log = ActiveSupport::Logger.new('log/data_import.log')
    log.info("Importing Draft Data")

    Draft.find_or_create_by(name: "NFL Draft", year: 2010, venue: "Dallas, TX")

    log.info("Importing Draft Data successful")
  end
end
