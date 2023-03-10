require_relative 'solution'

RSpec.describe Solution do
    describe '#return true if start_date =' do

      it '2023.07.14 periods = "2023", "2024", "2025"' do
        sl = Solution.new(["2023", "2024", "2025"], Date.new(2023,7,16))#true
        expect(sl.valid?).to be_truthy
      end
  
      it '2023.1.31 periods = "2023M1", "2023M2", "2023M3"' do
        sl = Solution.new(["2023M1", "2023M2", "2023M3"], Date.new(2023,1,31))#true
        expect(sl.valid?).to be_truthy
      end

      it '1976.6.4 periods = "1976M6D4", "1976M6D5", "1976M6D6"' do
        sl = Solution.new(["1976M6D4", "1976M6D5", "1976M6D6"], Date.new(1976,6,4)) #true
        expect(sl.valid?).to be_truthy
      end

      it '2023.01.30 periods = "2023M1", "2023M2", "2023M3D30"' do
        sl = Solution.new(["2023M1", "2023M2", "2023M3D30"], Date.new(2023,1,30)) #true
        expect(sl.valid?).to be_truthy
      end

      it '2020.01.30 periods = "2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D30"' do
        sl = Solution.new(["2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D30"], Date.new(2020,1,30))#true
        expect(sl.valid?).to be_truthy
        expect(sl.valid?(["2020M1", "2020M2D29"])).to be_truthy
      end

    end

    describe 'return false if start_date =' do

      it '2023.04.24 periods = "2023", "2025", "2026"' do
        sl = Solution.new(["2023", "2025", "2026"], Date.new(2023,4,24))
        expect(sl.valid?).to be_falsey
      end
  
      it '2023.1.10 periods = "2023M1", "2023M3", "2023M4"' do
        sl = Solution.new(["2023M1", "2023M3", "2023M4"], Date.new(2023,1,10))
        expect(sl.valid?).to be_falsey
      end

      it '2023.5.2 periods = "2023M5D2", "2023M5D3", "2023M5D5"' do
        sl = Solution.new(["2023M5D2", "2023M5D3", "2023M5D5"], Date.new(2023,5,2))
        expect(sl.valid?).to be_falsey
      end

      it '2023.01.31 periods = "2023M1", "2023M2", "2023M3D30"' do
        sl = Solution.new(["2023M1", "2023M2", "2023M3D30"], Date.new(2023,1,31))
        expect(sl.valid?).to be_falsey
      end

      it '2020.01.30 periods = "2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D29"' do
        sl = Solution.new(["2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D29"], Date.new(2020,1,30))#false
        expect(sl.valid?).to be_falsey
      end
        
      end

    describe 'While adding new period should' do

      it 'return true if correct' do
        sl = Solution.new(["2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D30"], Date.new(2020,1,30))#true
        expect(sl.add("2024")).to be_truthy
      end

      it 'return false if uncorrect' do
        sl = Solution.new(["2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D30"], Date.new(2020,1,30))#true
        expect(sl.add("2025")).to be_nil
      end

    end
end