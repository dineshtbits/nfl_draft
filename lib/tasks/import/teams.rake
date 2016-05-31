require 'csv'

class TeamsDataImporter
  def process
    delete_existing_divisions_data
    delete_existing_teams_data

    file_name = File.join(Rails.root, "teams.csv")
    CSV.foreach(file_name, {headers: true}) do |row|
      division = create_division_record_if_not_present(row)
      division.teams.create(name: sanitized_team_name(row))
    end
  end

  private

  def create_division_record_if_not_present row
    Division.find_or_create_by(name: sanitized_team_division(row))
  end

  def sanitized_team_division row
    row["Division"].strip
  end

  def sanitized_team_name row
    row["Team Name"].strip
  end

  def delete_existing_divisions_data
    Division.delete_all
  end

  def delete_existing_teams_data
    Team.delete_all
  end
end


namespace :import do
  desc 'Import Teams data from CSV file'
  task teams: :environment do
    log = ActiveSupport::Logger.new('log/data_import.log')
    log.info("Importing teams Data")

    TeamsDataImporter.new.process

    log.info("Importing teams Data succeeded")
  end
end
