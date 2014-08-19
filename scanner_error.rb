# copyright 2013, 2014 GitrDoneTuesday LLC, all rights reserved
class ScannerError
  def initialize(offs, sym, msg)
    @offset = offs
    @symbol = sym
    @message = msg
  end
  attr_accessor :offset, :symbol, :message
end
