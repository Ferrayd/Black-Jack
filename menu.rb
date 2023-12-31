# frozen_string_literal: true

# Класс для меню
class Menu
  def initialize
    @close = false
  end

  def title
    'Меню'
  end

  def items
    {}
  end

  def display
    return if items.empty?

    render until @close
  end

  protected

  def render
    puts title
    items.each { |key, value| puts "#{key}) #{value[:name]}" }
    handle_user_input
  end

  def handle_user_input
    menu_item = items.fetch(gets.chomp)
    send(*menu_item[:action])
  rescue KeyError
    puts 'Такой опции нет.'
  end

  def choose_item_from_array(items)
    return unless items.is_a?(Array) && !items.empty?

    display_array_items(items)
    items.fetch(gets.chomp.to_i - 1)
  rescue IndexError
    puts 'Такой опции нет.'
    retry
  end

  def display_array_items(items)
    return puts 'Отсутсвуют данные для отображения' if items.empty?

    items.each_with_index do |item, index|
      puts "#{index + 1}) #{item.name}" if item.class.method_defined? :name
    end
  end

  def close!
    @close = true
  end

  alias exit! close!
end
