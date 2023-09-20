# frozen_string_literal: true

require_relative 'player'

# Логика диллера
class Dealer < Player
  def initialize(bankroll)
    super('Диллер', bankroll)
  end

  def play(table)
    score = table.dealer_score
    table.deal_card_to_player(self) if score < 17
  end
end
