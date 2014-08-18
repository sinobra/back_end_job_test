module ConvertHelper
  BUTTON_NAMES = {
      "0" => "b0",
      "1" => "b1",
      "2" => "b2",
      "3" => "b3",
      "4" => "b4",
      "5" => "b5",
      "6" => "b6",
      "7" => "b7",
      "8" => "b8",
      "9" => "b9",
      "." => "bdot",
      "-" => "bminus",
      "c" => "bclear"

  }
  def to_buttons(v, klass)
    res = []
    v.each { |c| res.push( "<input id=\"#{BUTTON_NAMES[c]}\" class=\"#{klass}\"  type=\"button\" value=\"#{c}\" />")}
    res.join()
  end
end

