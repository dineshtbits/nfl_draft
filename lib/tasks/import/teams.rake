require 'csv'
# lib/tasks/import/teams.rake
namespace :import do
  desc 'Import Teams data from CSV file'
  task teams: :environment do
    log = ActiveSupport::Logger.new('log/teams.log')
    start_time = Time.now
    log.info "Task started at #{start_time}"

    Division.delete_all
    Team.delete_all
    file_name = File.join(Rails.root, "teams.csv")
    CSV.foreach(file_name, {headers: true}) do |row|
      division = Division.find_or_create_by(name: row["Division"].strip)
      division.teams.create(name: row["Team Name"].strip)
    end

    end_time = Time.now
    duration = (start_time - end_time) / 1.minute
    log.info "Task finished at #{end_time} and last #{duration} minutes."
    log.close
  end
end
