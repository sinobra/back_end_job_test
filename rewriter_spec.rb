require File.dirname(__FILE__) +'/rewriter'

VALUES = {
    'I' => 1,
    'V' => 5,
    'X' => 10,
    'L' => 50,
    'C' => 100,
    'D' => 500,
    'M' => 1000
}

describe Rewriter do

  before(:each) do
    @rewriter = Rewriter.new
    @rewriter2 = Rewriter.new
  end

  it 'should correctly convert values to Roman Numerals' do
    values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 2, 1]
    results = %w(M CM D CD C XC L XL X IX V IV II I)
    values.each_with_index do |val, ix|
      res = @rewriter.value2rnums(val)
      expect(res).to eq(results[ix])
      # puts "#{val.to_s}: #{results[ix]}"
    end
  end

  it 'should correctly pass through all legitimate subtractive sequences' do
    tests = %w(IV IX XL XC CD CM)
    tests.each do |s|
      rw = Rewriter.new
      res = rw.scan s
      puts res
      expect(res).to eq(s)
    end
  end

  it 'should condense arbitrary repeating sequences to their smallest form' do

    values = []
    inputs = []
    %w(I V X L C D M).each do |k|
      values.push(VALUES[k] * 14)
      inputs.push(k*14)
    end

    inputs.each_with_index do |str, ix|
      result = @rewriter.scan(str)
      result2 = @rewriter2.scan(result)

      expect(result).to eq(result2)
      expect(@rewriter.value()).to eq(@rewriter2.value())
      expect(@rewriter.value()).to eq(values[ix])
    end
  end

  it "should condense 4's of I to their subtractive forms" do
    res = @rewriter.scan('IIII')
    expect(res).to eq('IV')
    res = @rewriter2.scan('VIIII')
    expect(res).to eq('IX')
  end

  it "should condense 4's of X to their subtractive forms" do
    res = @rewriter.scan('XXXX')
    expect(res).to eq('XL')
    res = @rewriter2.scan('LXXXX')
    expect(res).to eq('XC')
  end

  it "should condense 4's of C to their subtractive forms" do
    res = @rewriter.scan('CCCC')
    expect(res).to eq('CD')
    res = @rewriter2.scan('DCCCC')
    expect(res).to eq('CM')
  end
end
