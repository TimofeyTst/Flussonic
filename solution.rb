require 'date'

class Solution
    attr_accessor :periods


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
                current_range = nil
            end
        end
        current_range
    end


    def valid?(periods = @periods)
        !get_periods_range(periods).nil?
    end

    
    def add period
        if valid?(@periods + [period])
            @periods += [period]
        end
    end
end

