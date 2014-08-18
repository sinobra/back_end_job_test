
When(/^on the page$/) do
  visit root_path
end

Then(/^should see initial page$/) do
  assert page#farhenheit.text == ''
  assert page#centigrade.text == ''
  assert page#f-active.text == '*'
end

Then /^should see centigrade marked$/ do
  assert find('.c-active').text == '*', ".c-active.text=#{find('.c-active').text}"
end

When(/^enter (\d+) in Fahrenheit$/) do |arg1|
  find("#fahrenheit").click
  arg1.split('').each do |n|
    click_button "b#{n}"
    puts "click_button b#{n}"

  end
end

When(/^enter (\d+) in Centigrade$/) do |arg1|
  find("#centigrade").click
  puts "switched to centigrade"
  arg1.split('').each do |n|
    click_button "b#{n}"
    puts "click_button b#{n}"
  end
end

Then(/^should see "(.*?)" in Centigrade$/) do |arg1|
 t = find('#centigrade').text
 puts "Text in centigrade =<#{page.find_by_id('centigrade').text}>"
 assert t == arg1, "actually saw <#{t}>"
end

Then(/^should see "(.*?)" in Fahrenheit$/) do |arg1|
  # puts "Text in fahrenheit =<#{page.find_by_id('fahrenheit').text}>"
  t = find('#fahrenheit').text
  assert t == arg1, "actually saw <#{t}>"
end



When(/^enter c$/) do
  click_button "bclear"
end

Then(/^should see nothing$/) do
  t = find('#fahrenheit').text
  assert t == '',  "expecting '' in Fahrenheit, found #{t} instead"
  t = find('#centigrade').text
  assert t == '', "expecting '' in Centigrade, found #{t} instead"
end


When(/^enter \-$/) do
  click_button "bminus"
end

When(/^enter minus at the end of a Fahrenheit number$/) do
  find("#fahrenheit").click
  click_button 'bclear'
  click_button 'b2'
  click_button 'b1'
  click_button 'b2'
  click_button 'bminus'
end

Then(/^minus is prepended to both Fahrenheit and Centigrade numbers$/) do
  t = find('#fahrenheit').text
  assert t == "-212", "expecting -212 in Fahrenheit, found #{t} instead"
  t = find('#centigrade').text
  assert t == "-135.6", "expecting -135.6 in Centigrade, found #{t} instead"
end

When(/^enter minus at the end of a Centigrade number$/) do
  find("#centigrade").click
  click_button 'bclear'
  click_button 'b1'
  click_button 'b3'
  click_button 'b5'
  click_button 'bdot'
  click_button 'b6'
  click_button 'bminus'
end
Then(/^minus is prepended to both Centigrade and Fahrenheit numbers$/) do
  t = find('#fahrenheit').text
  assert t == "-212.1", "expecting -212.1 in Fahrenheit, found #{t} instead"
  t = find('#centigrade').text
  assert t == "-135.6", "expecting -135.6 in Centigrade, found #{t} instead"
end

When(/^enter minus multiple times$/) do
  find("#centigrade").click
  click_button 'bclear'
  click_button 'bminus'
  click_button 'bminus'
  click_button 'bminus'
end

Then(/^only one minus shows$/) do
  t = find('#fahrenheit').text
  assert t == "-", "expecting - in Fahrenheit, found #{t} instead"
  t = find('#centigrade').text
  assert t == "-", "expecting - in Centigrade, found #{t} instead"
end

When(/^enter decimal\-point multiple times$/) do
  find("#centigrade").click
  click_button 'bclear'
  click_button 'bdot'
  click_button 'bdot'
  click_button 'bdot'
end

Then(/^only one decimal\-point shows$/) do
  t = find('#fahrenheit').text
  assert t == ".", "expecting '.' in Fahrenheit, found #{t} instead"
  t = find('#centigrade').text
  assert t == ".", "expecting '.' in Centigrade, found #{t} instead"
end

When(/^enter minus at the beginning of a Fahrenheit field$/) do
  find("#fahrenheit").click
  click_button 'bclear'
  click_button 'bminus'
end

Then(/^no calculation is done in the Centigrade field$/) do
  t = find('#centigrade').text
  assert t == "-", "expecting '-' in Centigrade, found #{t} instead"
end

When(/^enter minus at the beginning of a Centigrade field$/) do
  find("#centigrade").click
  click_button 'bclear'
  click_button 'bminus'
end

Then(/^no calculation is done in the Fahrenheit field$/) do
  t = find('#fahrenheit').text
  assert t == "-", "expecting '-' in Fahrenheit, found #{t} instead"
end

When(/^enter minus\-dot at the beginning of a Fahrenheit field$/) do
  find("#fahrenheit").click
  click_button 'bclear'
  click_button 'bminus'
  click_button 'bdot'
end

When(/^enter minus\-dot at the beginning of a Centigrade field$/) do
  t = find('#centigrade').text
  assert t == "-.", "expecting '-.' in Centigrade, found #{t} instead"
end

Then(/^minus\-dot is copied to the Centigrade field$/) do
  t = find('#centigrade').text
  assert t == "-.", "expecting '-.' in Centigrade, found #{t} instead"
end

Then(/^minus\-dot is copied to  the Fahrenheit field$/) do
  t = find('#fahrenheit').text
  assert t == "-.", "expecting '-.' in Fahrenheit, found #{t} instead"
end
