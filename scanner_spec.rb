require File.dirname(__FILE__) +'/scanner'


describe Scanner do
  before(:each) do
    @scanner = Scanner.new
  end
  it "should accept indeterminate sequences of the same numeral" do
    inputs = [
        'I'*14,
        'V'*14,
        'X'*14,
        'L'*14,
        'C'*14,
        'D'*14,
        'M'*14
    ].each do |str|
        tokens = @scanner.scan(str)
        expect(tokens.length).to eq(14)
      end
    end

  it "should accept all sequences of numerals of decending value" do

    nums = %w(M D C L X V I)
    while nums.length > 1
      car = nums.shift
      nums.each do |num|
        str = car + num
        begin
          @scanner.scan str
        rescue Exception => e
          fail(e.message)
        end
      end
    end
  end

  it 'should accept all legal subtractive notations' do
    tests = {
        'I' => %w(V X),
        'X' => %w(L C),
        'C' => %w(D M)
    }
    tests.keys.each do |k|
      sfxs = tests[k]
      sfxs.each do |sfx|
        str = k + sfx
        begin
          @scanner.scan str
        rescue Exception => e
          fail(e.message)
        end
      end
    end
  end

  it 'should reject all legal subtractive notations if preceded by multiples of subtractive numeral e.g.: IIIX ' do
    tests = {
        'I' => %w(V X),
        'X' => %w(L C),
        'C' => %w(D M)
    }
    tests.keys.each do |k|
      sfxs = tests[k]
      sfxs.each do |sfx|
        str = k + k + sfx
        begin
          @scanner.scan str
          fail(e.message)
        rescue Exception => e
          puts "Expected failure"
        end
      end
    end
  end


  it 'should reject all illegal subtractive notations' do
    tests = {
        'I' => %w(L C D M),
        'V' => %w(X L C D M),
        'X' => %w(D M),
        'L' => %w(C D M),
        'D' => %w(M)
    }
    tests.keys.each do |k|
      sfxs = tests[k]
      sfxs.each do |sfx|
        str = k + sfx
        begin
          @scanner.scan str
          fail(e.message)
        rescue Exception => e
          puts "Expected failure"
        end
      end
    end
  end

  it 'should reject all non-roman-numerals' do
    begin
      @scanner.scan "IXVeM"
      fail("should have detected non-Roman Numeral")
    rescue Exception => e
      puts "Expected failure"
    end
  end

  it 'should correctly pass through all legitimate subtractive sequences' do
    tests = %w(IV IX XL XC CD CM)
    tests.each do |s|
      res = @scanner.scan s
      # puts res
      expect(res[0]).to eq(s)
    end
  end



end
