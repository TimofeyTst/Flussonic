require_relative 'solution'

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
    # puts sl.valid?
    puts "--------------"
    puts sl.valid?(["2020M1", "2020M2D29"]) # true
    puts sl.valid?(["2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D30", "2024M3D31"]) # true
    sl = Solution.new(["2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D30"], Date.new(2020,1,30))#true
    puts sl.valid?
    p sl.add("2025") ? "Цепочка дат корректна" : "Цепочка дат некорректна"
    p sl.add("2024") ? "Цепочка дат корректна" : "Цепочка дат некорректна"
end

Testfunc()