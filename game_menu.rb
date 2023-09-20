# frozen_string_literal: true

require_relative 'menu'

# Класс игрового меню
class GameMenu < Menu
  FIRST_TURN_STRUCTURE = {
    '1' => {
      name: 'Добавить карту',
      action: :handle_hit
    },
    '2' => {
      name: 'Пропустить',
      action: :handle_stand
    },
    '3' => {
      name: 'Открыть карты',
      action: :open_cards
    },
    '0' => {
      name: 'Закончить игру',
      action: :exit!
    }
  }.freeze

  SECOND_TURN_STRUCTURE = {
    '1' => {
      name: 'Добавить карту',
      action: :handle_hit
    },
    '2' => {
      name: 'Открыть карты',
      action: :open_cards
    },
    '0' => {
      name: 'Quit Game',
      action: :close!
    }
  }.freeze

  def initialize(table)
    @table = table
  end

  def title
    "Раунд ##{@table.round} - Ваш ход:"
  end

  def items
    return SECOND_TURN_STRUCTURE if @table.second_turn?

    FIRST_TURN_STRUCTURE
  end

  private

  def handle_hit
    close!
    @table.hit
  end

  def handle_stand
    close!
    @table.stand
  end

  def open_cards
    close!
    @table.open_cards
  end
end
