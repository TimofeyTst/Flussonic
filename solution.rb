require 'date'
require 'time'

# Реализуем функцию добавления, которая будет проверять валидность 

class Solution
    def initialize(periods, start_date)
        @periods = periods
        @start_date = start_date
    end

    # Проверка возможности образовать из двух диапазонов новый
    def ranges_continue?(range1, range2)
        (range2.first <= range1.last) && (range1.last < range2.last)
    end

    # Создает из строкового периода период в виде диапазона дат,
    # и возвращает вместе с типом (год, месяц или день)
    def get_date_range(date)
        if date.match?(/^\d{4}M([1-9]|1[0-2])D\d{1,2}$/)
            st_range = Date.new(date[0..3].to_i, date[date.index("M")+1..].to_i, date[date.index("D")+1..].to_i)
            end_range = st_range.next_day
            type = "yymmdd"
        elsif date.match?(/^\d{4}M([1-9]|1[0-2])$/)
            st_range = Date.new(date[0..3].to_i, date[date.index("M")+1..].to_i)
            end_range = st_range.next_month
            type = "yymm"
        elsif date.match?(/^\d{4}$/)
            st_range = Date.new(date[0..3].to_i)
            end_range = st_range.next_year
            type = "yy"
        end
        [st_range..end_range, type]
    end

    # Формирует диапазон дат от начальной, пока они валидны
    def get_periods_range(periods) 
        current_range = @start_date..@start_date

        periods.take_while do |period|
            next_range = get_date_range(period) # Парсим очередной период в диапазон дат

            if ranges_continue?(current_range, next_range[0])
                case next_range[1]
                when "yymmdd"
                    current_range = current_range.first..current_range.last + 1

                when "yymm"
                    if current_range.last.month == 2
                        end_range = Date.new(current_range.last.year, current_range.last.month + 1, @start_date.day)
                    else
                        end_range = current_range.last.next_month
                    end
                    current_range = current_range.first..end_range

                when "yy"
                    current_range = current_range.first..current_range.last.next_year
                end
            else
                # puts "False Current range - next_range", current_range, next_range
                current_range = nil
            end
        end
        current_range
    end

    def valid?(periods = @periods)
        # puts get_periods_range unless get_periods_range.nil?
        !get_periods_range(periods).nil?
    end
end






def Testfunc
    sl = Solution.new(["2023", "2024", "2025"], Date.new(2023,7,16))#true
    puts sl.valid?
    sl = Solution.new(["2023", "2025", "2026"], Date.new(2023,4,24))#false
    puts sl.valid?
    sl = Solution.new(["2023M1", "2023M2", "2023M3"], Date.new(2023,1,31))#true
    puts sl.valid?
    sl = Solution.new(["2023M1", "2023M3", "2023M4"], Date.new(2023,1,10))#false
    puts sl.valid?

    sl = Solution.new(["1976M6D4", "1976M6D5", "1976M6D6"], Date.new(1976,6,4)) #true
    puts sl.valid?
    sl = Solution.new(["2023M5D2", "2023M5D3", "2023M5D5"], Date.new(2023,5,2)) #false
    puts sl.valid?
    sl = Solution.new(["2023M1", "2023M2", "2023M3D30"], Date.new(2023,1,30)) #true
    puts sl.valid?
    sl = Solution.new(["2023M1", "2023M2", "2023M3D30"], Date.new(2023,1,31)) #false
    puts sl.valid?
    sl = Solution.new(["2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D30"], Date.new(2020,1,30))#true
    puts sl.valid?
    sl = Solution.new(["2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D29"], Date.new(2020,1,30))#false
    puts sl.valid?
    puts "--------------"
    puts sl.valid?(["2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D30", "2024M3D31"])
end

Testfunc()
