Feature: Log in/out links
  In order to easily log in and log out
  As a user
  I want to see the appropriate link

  @omniauth_test
  Scenario: A guest user should see a login link
    Given I am not logged in
    And I am on the homepage
    Then I should see a login link
    And I should see "Login" as the text of the login link

  @omniauth_test
  Scenario: A logged in user on the search page should see a logout link
    Given I am logged in
    And I am on the homepage
    Then I should see a logout link
    And I should see "Log-out Dev" as the text of the logout link

  @omniauth_test
  Scenario: A non aleph logged in user should have access denied
    Given I am logged in as a non aleph user
    And I am on the homepage
    Then I should see a logout link
    And I should see "Log-out Dev" as the text of the logout link
