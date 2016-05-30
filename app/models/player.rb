class Player < ActiveRecord::Base
  has_many :ownerships
  has_many :teams, through: :ownerships
end
