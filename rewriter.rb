require File.dirname(__FILE__) +'/scanner'

class Rewriter

  attr_accessor :value

  VALUES = {
      'I' => 1,
      'V' => 5,
      'X' => 10,
      'L' => 50,
      'C' => 100,
      'D' => 500,
      'M' => 1000,
      'IX' => 9,
      'IV' => 4,
      'XL' => 40,
      'XC' => 90,
      'CD' => 400,
      'CM' => 900
  }

  DIVISORS = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4]
  SINGULAR_DIVISORS = [ 900, 400, 90, 40, 9 , 4]

  DIVISORS2LLETTERS = {
      1000 => 'M',
      900 => 'CM',
      500 => 'D',
      400 => 'CD',
      100 => 'C',
      90 => 'XC',
      50 => 'L',
      40 => 'XL',
      10 => 'X',
      9 => 'IX',
      5 => 'V',
      4 => 'IV',
      1 => 'I'
    }

  def initialize
    @scanner = Scanner.new
    @errors = []
  end

  def value_error(first, second)
    @errors << "Value error: raw input valued at: #{first}, rewritten expression valued at: #{second}\n"
  end

  def rewrite_error(first, second)
    @errors << "Rewrite error: original text is shorter than the rewritten text.\n" +
        "     origninal: <#{first}>\n" +
        "     rewritten: <#{second}>\n"
  end

  def convert_to_value(tokens)
    # puts "hello from convert to value(#{tokens.to_s})"
    res = 0
    tokens.each { |t| res += VALUES[t]}
    res
  end

  def value2rnums(v)
    # puts "hello from value2rnums(#{v.to_s}"
    res = ''
    DIVISORS.each do |d|
      break if v == 0
      factor = v/d
      next if factor == 0
      if factor == 1
        res += DIVISORS2LLETTERS[d]
      else
        res += (DIVISORS2LLETTERS[d] * factor) unless SINGULAR_DIVISORS.include? d
      end
      v -= factor*d
    end
    res += ('I'*v) if v > 0
    res
  end


  def rewrite_tokens(tokens)
    #puts "hello from rewrite tokens #{tokens.to_s}"
    value = convert_to_value(tokens)
    value2rnums(value)
  end



  def scan(str)
    #puts "Scanning #{str}"
    tokens = []
    initial_value = 0
    rewrite_value = 0
    begin
      tokens = @scanner.scan str.upcase
      initial_value = convert_to_value tokens
      rewritten_string = rewrite_tokens tokens
      rewrite_value = convert_to_value tokens

      if initial_value == rewrite_value
        @value = initial_value
      else
        value_error(initial_value, rewrite_value)
      end
      if tokens.join.length < rewritten_string.length
        rewrite_error(tokens.join, rewritten_string)
      end
    rescue Exception => e
      @errors << "Sorry, could not scan your input string: #{e.message}"
    end
    if @errors.empty?
      rewritten_string
    else
      puts @errors.join("\n")
      raise Exception.new("Parsing errors")
    end
  end
end
