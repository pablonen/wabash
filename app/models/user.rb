class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :game_players
  has_many :games, through: :game_players

  def in_game?(game)
    games.find_by(id: game.id)
  end
end
