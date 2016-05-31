require 'csv'

class PlayersDataImporter
  def process
    delete_existing_players_data
    file_name = File.join(Rails.root, "players.csv")
    CSV.foreach(file_name, {headers: true}) do |row|
      create_player_record(row)
    end
  end

  private

  def delete_existing_players_data
    Player.delete_all
  end

  def create_player_record row
    Player.find_or_create_by(name: sanitized_player_name(row), position: sanitized_player_position(row))
  end

  def sanitized_player_name row
    row["Player Name"].strip
  end

  def sanitized_player_position row
    row["Position"].strip
  end
end


namespace :import do
  desc 'Import Players data from CSV file'
  task players: :environment do
    log = ActiveSupport::Logger.new('log/data_import.log')
    log.info("Importing players Data")

    PlayersDataImporter.new.process
    log.info("Importing players Data succeeded")
  end
end
