# lib/tasks/simulate/draft_process.rake
namespace :simulate do
  desc 'Simulating draft process'
  task draft_process: :environment do
    log = ActiveSupport::Logger.new('log/draft_process.log')
    start_time = Time.now
    log.info "Task started at #{start_time}"

    puts "starting draft"
    draft = Draft.where(year: 2010).first
    puts "Getting the next pick"
    current_pick = draft.next_picks.first
    while current_pick.present?
      # Get a list of available players.
      puts "Now running Round #{current_pick.round} Pick #{current_pick.pick}"
      puts "Picking from draftable players"
      picked_player = draft.draftable_players.sample
      puts "Picked player ID # {picked_player.id} Name #{picked_player.name}"
      puts "This pick is complete - Moving on to next pick" if current_pick.assign_player(picked_player.id)
      puts "-"*150
      current_pick = draft.next_picks.first
    end
    puts "All picks are complete for this draft."

    end_time = Time.now
    duration = (start_time - end_time) / 1.minute
    log.info "Task finished at #{end_time} and last #{duration} minutes."
    log.close
  end
end
