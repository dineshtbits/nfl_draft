require 'csv'
# lib/tasks/import/draft.rake
namespace :import do
  desc 'Import Draft data '
  task draft: :environment do
    log = ActiveSupport::Logger.new('log/draft.log')
    start_time = Time.now
    log.info "Task started at #{start_time}"
    Draft.find_or_create_by(name: "NFL Draft", year: 2010, venue: "Dallas, TX")
    end_time = Time.now
    duration = (start_time - end_time) / 1.minute
    log.info "Task finished at #{end_time} and last #{duration} minutes."
  end
end
