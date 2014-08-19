require File.dirname(__FILE__) +'/scanner_error'

class Scanner


  LEGAL_SYMBOLS = %w(I V X L C D M)

  LEGAL_SUBTRACTIVES = {
      'I' => %w(V X),
      'X' => %w(L C),
      'C' => %w(D M)
  }

  PREFIXES = %w(I X C)

  def prefixes_subtractive(current, nxt)
    LEGAL_SUBTRACTIVES[current].include?[nxt]
  end


  def initialize()
    @message = nil
  end

  def is_legit(str)
    return LEGAL_SYMBOLS.include?(str)
  end

  def illegally_prefixes_subtractive(result, cur, nxt)
    return false if result.empty?
    return true if result.last == cur && prefixes_subtractive(cur, nxt)
    false
  end

  def prefixes_subtractive(first, second)
    return false unless PREFIXES.include?(first)
    return true if LEGAL_SUBTRACTIVES[first].include?(second)
    false
  end

  private
  def print_errors
    puts "Scanning Errors"
    puts "[ " + @input + " ]"
    @errors.each do |e|
      puts "at offset: #{e.offset}, symbol: #{e.symbol}, #{e.message}"
    end
  end

  public
  def scan(str)
    @input = str
    @errors = []
    rnums = str.split("")
    result = []
    ix = 1
    while rnums.length > 0
      cur = rnums.shift.upcase
      unless is_legit(cur)
        @errors << ScannerError.new(ix, cur, 'not a Roman Numeral')
      else
        if illegally_prefixes_subtractive(result, cur, rnums.first)
          @errors << ScannerError.new(ix, cur, "can't have larger Numeral after Smaller")
        else
          if prefixes_subtractive(cur, rnums.first)
            result.push(cur + rnums.shift)
          else
            result.push(cur)
          end
        end
      end
      unless @errors.empty?
        print_errors
        raise Exception.new("Scanning Errors")
      end
     end
    result
  end
end
