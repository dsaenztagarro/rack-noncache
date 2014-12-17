Feature: Cache control in browser navigation
  Scenario: Pressing back browser button
    Given I choose a firefox browser
    And I visit the home page
    And I store 3 todo tasks in session
    When I click on Show details
    And I press the back browser button
    Then I see the 3 todo tasks in todo list