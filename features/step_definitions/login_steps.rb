Around('@omniauth_test') do |scenario, block|
  OmniAuth.config.test_mode = true
  block.call
  OmniAuth.config.test_mode = false
end

Given(/^I am logged in$/) do
  OmniAuth.config.mock_auth[:nyulibraries] = omniauth_hash
  @ignored = true
  visit '/login'
end

Given(/^I am not logged in$/) do
  OmniAuth.config.mock_auth[:nyulibraries] = nil
end

Given(/^I am logged in as a non aleph user$/) do
  OmniAuth.config.mock_auth[:nyulibraries] = non_aleph_omniauth_hash
  @ignored = true
  visit '/login'
end

Then(/^I should see a login link$/) do
  expect(page).to have_css('.nyu-login i.icons-famfamfam-lock_open')
  expect(page).to have_css('.nyu-login a.login')
end

Then(/^I should see "(.*?)" as the text of the login link$/) do |text|
  login_link = find(:css, '.nyu-login a.login')
  expect(login_link).to have_text text
end

Then(/^I should see a logout link$/) do
  expect(page).to have_css('.nyu-login i.icons-famfamfam-lock')
  expect(page).to have_css('.nyu-login a.logout')
end

Then(/^I should see "(.*?)" as the text of the logout link$/) do |text|
  logout_link = find(:css, '.nyu-login a.logout')
  expect(logout_link).to have_text text
end

Then(/^I should see the login page in the current window$/) do
  expect(page).to have_text 'Select your affiliation'
end

Given(/^I am on the homepage$/) do
  visit search_catalog_path
end

When(/^I click the login link$/) do
  click_on "Login"
end

When(/^I click on "(.*?)"$/) do |link|
  click_on link
end

Then(/^I should be logged out$/) do
  expect(page).to have_text 'Almost logged out'
end
