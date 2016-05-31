class DraftProcessSimulator

  def initialize
    @draft = Draft.where(year: 2010).first
  end

  def start
    puts "starting the draft"
    puts "Getting the next pick"
    current_pick = @draft.next_picks.first
    while current_pick.present?
      puts "Now running Round #{current_pick.round} Pick #{current_pick.pick}"
      puts "Picking from draftable players"
      picked_player = @draft.draftable_players.sample
      puts "Picked player ID #{picked_player.id} Name #{picked_player.name}"
      puts "This pick is complete - Moving on to next pick" if current_pick.assign_player(picked_player.id)
      puts "-"*150
      current_pick = @draft.next_picks.first
    end
    puts "All picks are complete for this draft."
  end
end


namespace :simulate do
  desc 'Simulating draft process'
  task draft_process: :environment do
    DraftProcessSimulator.new.start
  end
end
