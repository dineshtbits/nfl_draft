require 'csv'

class DraftOrderDataImporter
  def process
    delete_existing_data

    file_name = File.join(Rails.root, "order.csv")
    CSV.foreach(file_name, {headers: true}) do |row|
      team = get_team(row)
      draft = get_draft
      create_ownership_record(team, draft, sanitized_round(row), sanitized_pick(row))
    end
  end

  private

  def delete_existing_data
    Ownership.delete_all
  end

  def get_team row
    Team.where(name: derived_team_name(row)).first
  end

  def get_draft
    Draft.where(year: 2010).first
  end

  def create_ownership_record(team, draft, round, pick)
    Ownership.create!(team_id: team.id, draft_id: draft.id, round: round, pick: pick)
  end

  def sanitized_pick row
    row["Pick"].strip.to_i
  end

  def sanitized_round row
    row["Round"].strip.to_i
  end

  def derived_team_name row
    special_teams.keys.include?(sanitized_team_name(row)) ? special_teams[sanitized_team_name(row)] : sanitized_team_name(row)
  end

  def sanitized_team_name row
    row["Team Name"].strip
  end


  def special_teams
    { "NY Jets" => "New York Jets", "NY Giants" => "New York Giants" }
  end
end

namespace :import do
  desc 'Import draft order data from CSV file'
  task draft_order: :environment do
    log = ActiveSupport::Logger.new('log/data_import.log')
    log.info("Importing draft order data")

    DraftOrderDataImporter.new.process

    log.info("Importing draft order data succeeded")
  end
end
