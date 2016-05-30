require 'csv'
# lib/tasks/import/draft_order.rake
namespace :import do
  desc 'Import draft order data from CSV file'
  task draft_order: :environment do
    log = ActiveSupport::Logger.new('log/draft_order.log')
    start_time = Time.now
    log.info "Task started at #{start_time}"

    Ownership.delete_all
    file_name = File.join(Rails.root, "order.csv")
    CSV.foreach(file_name, {headers: true}) do |row|
      special_teams = {"NY Jets" => "New York Jets", "NY Giants" => "New York Giants"}
      row["Team Name"] = row["Team Name"].strip
      team_name = special_teams.keys.include?(row["Team Name"]) ? special_teams[row["Team Name"]] : row["Team Name"]
      team = Team.where(name: team_name).first
      draft = Draft.where(year: 2010).first
      Ownership.create(team_id: team.id, draft_id: draft.id, round: row["Round"].strip, pick: row["Pick"].strip)
    end

    end_time = Time.now
    duration = (start_time - end_time) / 1.minute
    log.info "Task finished at #{end_time} and last #{duration} minutes."
  end
end
