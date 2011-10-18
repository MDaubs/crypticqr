Given /^I have set a session password of "([^"]*)"$/ do |session_password|
  visit root_path
  fill_in "password", :with => session_password
  click_button "Set password"
end

Given /^I have not set a session password$/ do
end

When /^I go to the decode page for a QR code generated with the password "([^"]*)" and text "([^"]*)" with no session password$/ do |password, plaintext|
  Given "I have set a session password of \"#{password}\""
  And   "I complete the encode QR code form with the text \"#{plaintext}\""
  qr_code = page.find("div.ciphertext pre").text
  And   "I go to the home page"
  And   "I clear the session password"
  visit decode_path(:c => qr_code)
end

When /^I go to the decode page for a QR code generated with the password "([^"]*)" and text "([^"]*)" with the session password "([^"]*)"$/ do |password, plaintext, session_password|
  Given "I have set a session password of \"#{password}\""
  And   "I complete the encode QR code form with the text \"#{plaintext}\""
  qr_code = page.find("div.ciphertext pre").text
  And   "I go to the home page"
  And   "I clear the session password"
  And   "I have set a session password of \"#{session_password}\""
  visit decode_path(:c => qr_code)
end

When /^I complete the encode QR code form with the text "([^"]*)"$/ do |plaintext|
  fill_in "p", :with => plaintext
  click_button "Encode"
end

Then /^I see "([^"]*)"$/ do |what_to_see|
  page.should have_content(what_to_see)
end

Then /^I should see an encoded and encrypted QR code for the text "([^"]*)"$/ do |plaintext|
  page.should have_selector("img[src*='chart.googleapis.com']")
end

Then /^I get an error$/ do
  page.should have_selector("div#alert")
end
