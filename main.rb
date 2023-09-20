# frozen_string_literal: true

require_relative 'player'
require_relative 'dealer'
require_relative 'table'
require_relative 'game_menu'

# Главный класс приложения
class App
  BANKROLL_AMOUNT = 100

  def initialize
    @table = init_table
    @game_menu = GameMenu.new(@table)
  end

  def run
    @table.start_new_round
  end

  def on_round_start
    puts 'Ставки'
    puts 'Раздача карт'
  end

  def on_deal_card(player)
    puts "#{player.name} берет карту"
  end

  def on_player_turn
    show_info
    GameMenu.new(@table).display
  end

  def on_showdown(winner:, bank:)
    puts "Ваши карты: #{@table.player_hand}, очки: #{@table.player_score}"
    puts "Карты диллера: #{@table.dealer_hand}, очки: #{@table.dealer_score}"
    puts winner ? "#{winner.name} выигрывает $#{bank}!" : 'Ничья'
    prompt_for_new_round
  end

  def on_rebuy(player, min_bankroll)
    puts "У игрока #{player.name} недостаточно средств, ($#{min_bankroll} required). Пожалуйтса, докупите"
  end

  private

  def init_table
    puts 'Введите имя:'
    name = gets.strip.chomp.capitalize
    raise if name.empty?

    player = Player.new(name, BANKROLL_AMOUNT)
    dealer = Dealer.new(BANKROLL_AMOUNT)
    Table.new(player, dealer, self)
  rescue RuntimeError
    puts 'Имя не может быть пустым'
    retry
  end

  def show_info
    puts "Ваши карты: #{@table.player_hand}, очки: #{@table.player_score}, ставка: $#{@table.player_bankroll}"
    puts " Карты диллера: #{@table.dealer_hand}, ставка: $#{@table.dealer_bankroll}"
    puts " Банк: $#{@table.bank}"
  end

  def prompt_for_new_round
    loop do
      puts 'Хотите продолжить? [Y/N]'
      choice = gets.chomp
      if choice == 'Y'
        run
        break
      elsif choice == 'N'
        on_quit_game
        break
      else
        puts 'Такой опции нет, введите Y/N'
      end
    end
  end

  def on_quit_game
    puts 'До встречи'
  end
end

App.new.run
