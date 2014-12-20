Feature: Disable cache in browser navigation

  Scenario Outline: Pressing back browser button
    Given a <Strategy> for no caching my web application
    And I open a '<Browser>' <Version>
    And I visit the home page
    And I store 3 todo tasks in session
    When I click on Show details
    And I press the back browser button
    Then I see the 3 todo tasks in todo list

    Examples:
      | Browser           | Version | Strategy  |
      | firefox           | ANY     | whitelist |
      | firefox           | ANY     | blacklist |
      | chrome            | ANY     | whitelist |
      | opera             | ANY     | whitelist |
      | safari            | ANY     | whitelist |
      | internet explorer | 8       | whitelist |
      | internet explorer | 9       | whitelist |