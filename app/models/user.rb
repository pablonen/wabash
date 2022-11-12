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

  def acting?(game)
    game.user_acting?(self)
  end

  def seat_in(game)
    game.game_players.find_by(user_id: id).seat
  end

  # TODO, when leaving this goes haywire
  def join_in(game)
    game_players.create(game: game, seat: game.players.size)
  end

  def money(game)
    game.player_money(self)
  end

  def shares(game)
    game.player_shares(self)
  end
end
