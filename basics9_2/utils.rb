module Utils
  module_function

  def show_menu_with_select(menu, message, clear_screen = false)
    menu_id = nil
    until menu_id
      show_menu(menu, message, clear_screen)
      menu_id = select_menu(menu)
    end
    menu_id
  end

  def show_menu(menu, message, clear_screen = false)
    system('clear') if clear_screen
    puts message
    menu.each { |k, v| puts "#{k}. #{v}" }
  end

  def select_menu(menu)
    menu_id = gets.to_i
    if menu.key?(menu_id)
      menu_id
    else
      puts 'Неверный выбор'
      sleep 2
      false
    end
  end
end
