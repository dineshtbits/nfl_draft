class Ownership < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  belongs_to :draft

  def assign_player(player_id)
    self.player_id = player_id
    begin
      self.save
    rescue ActiveRecord::RecordNotUnique => error
      self.errors.add(:base, 'A player is already assigned to this pick. Please refresh to view next pick.')
      false
    end
  end
end
