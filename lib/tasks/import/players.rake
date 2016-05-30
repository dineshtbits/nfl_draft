require 'csv'
# lib/tasks/import/players.rake
namespace :import do
  desc 'Import Players data from CSV file'
  task players: :environment do
    log = ActiveSupport::Logger.new('log/players.log')
    start_time = Time.now
    log.info "Task started at #{start_time}"

    Player.delete_all
    file_name = File.join(Rails.root, "players.csv")
    CSV.foreach(file_name, {headers: true}) do |row|
      Player.find_or_create_by(name: row["Player Name"].strip, position: row["Position"])
    end

    end_time = Time.now
    duration = (start_time - end_time) / 1.minute
    log.info "Task finished at #{end_time} and last #{duration} minutes."
    log.close
  end
end
