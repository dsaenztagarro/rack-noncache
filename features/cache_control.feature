Feature: Cache control in browser navigation
  Scenario: Add two numbers
    Given I open a firefox browser
    And I visit home page
    And I make an ajax action
    When I visit the next page
    And I press back browser button
    Then I see the home page with the previous ajax action status