require_relative 'solution'

puts "Введите start_date периода в формате YYYY.MM.DD:"
start_date = Date.parse(gets.chomp)

puts "Введите строку периодов дат в формате '2022M2 2022M3 2022M4D1' разделяя их одним пробелом:"
date_string = gets.chomp

sl = Solution.new(date_string.split, start_date)
puts sl.valid? ? "Цепочка дат корректна" : "Цепочка дат некорректна"

puts "'1' для проверки корректности дат'" 
puts "'2' для ввода новой строки"
puts "'c' для выхода из программы:"

loop do
  print "\nВведите команду: " 

  input = gets.chomp
  case input
  when "1"
    puts sl.valid? ? "Цепочка дат корректна" : "Цепочка дат некорректна"
  when "2"
    puts "Введите новый период в формате '2022M2D30' | '2023M1' | '2024'. Он будет добавлен в цепочку, если она валидна:"
    date_string = gets.chomp
    # sl.add(date_string) ? 'Период был успешно добавлен' : 'Цепочка не валидна, добавления не произошло'
    if sl.add(date_string).nil? 
        puts  'Цепочка не валидна, добавления не произошло'
    else
        puts 'Период был успешно добавлен'
    end
  when "c", "C", "с", "С"
    break
  else
    puts "Неверный ввод, попробуйте еще раз"
  end
end
