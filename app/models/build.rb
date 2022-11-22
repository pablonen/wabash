# building related logic
class Build
  extend ActiveModel::Naming
  def initialize(acting_user, acting_company, game, hexes)
    @actor = acting_user
    @company = acting_company
    @game = game
    @hexes = hexes.reject{ |hex| hex == 'undefined' }
    @cost = @game.build_cost_for(@hexes)
    @errors = ActiveModel::Errors.new(self)
  end

  attr_accessor :game, :hexes, :actor, :company, :cost
  attr_reader :errors

  def valid?
    not_ended? &&
    on_turn? &&
    started? &&
    build_available? &&
    allowed_number_of_tracks? &&
    enough_tracks_to_build? &&
    sufficient_money? &&
    player_owns_shares? &&
    connected_to_company_track?
  end

  def not_ended?
    @game.errors.add(:base, "The game has ended!") if @game.ended_at
    !@game.ended_at
  end

  def started?
    @game.errors.add(:base, "The Game has not started!") unless @game.started?
    @game.started?
  end

  def build_available?
    @game.errors.add(:base, "No more build actions available") unless @game.build_available?
    @game.build_available?
  end

  def on_turn?
    @game.errors.add(:base, "It is not your turn to build!") unless @game.user_acting?(@actor)
    @game.user_acting?(@actor)
  end

  def allowed_number_of_tracks?
    @game.errors.add(:base, "Can only build 3 tracks per turn") if @hexes.size > 3
    @hexes.size < 4
  end

  def enough_tracks_to_build?
    @game.errors.add(:base, "Company does not have enough tracks to build #{@hexes.size} hexes") if @hexes.size > @game.state['companies'][@company]['track']
    @hexes.size < @game.state['companies'][@company]['track']
  end

  def sufficient_money?
    @game.errors.add(:base, "Company does not have enough money") if @cost > @game.state['companies'][@company]["money"]
    @cost < @game.state['companies'][@company]["money"]
  end

  def player_owns_shares?
    player_shares = @actor.shares(@game)
    @game.errors.add(:base, "You need to own shares of the company building!") unless player_shares.include? @company
    player_shares.include? @company
  end

  def connected_to_company_track?
    axial_company_built_tracks = @game.company_built_tracks(@company).map do |hex|
      offset_hex = HexPathfinding.destructure_hex_coordinate(hex)
      HexPathfinding.oddq_to_axial(offset_hex)
    end
    axial_to_be_built = hexes.map do |hex|
      offset_hex = HexPathfinding.destructure_hex_coordinate(hex)
      HexPathfinding.oddq_to_axial(offset_hex)
    end

    connected = @game.builds_adjacent_to_track?(axial_to_be_built, axial_company_built_tracks)

    @game.errors.add(:base, "Proposed track is not connected to the company track") unless connected
    connected
  end

  # Implementation boilerplate see https://api.rubyonrails.org/v7.0.4/classes/ActiveModel/Errors.html 
  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.human_attribute_name(attr, options = {})
    attr
  end

  def self.lookup_ancestors
    [self]
  end
end
