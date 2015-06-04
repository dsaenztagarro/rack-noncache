Feature: Disable cache in browser navigation

  Scenario Outline: Pressing back browser button
    Given a <Strategy> for no caching my web application
    And I am a <Platform> user
    And I open a '<Browser>' <Version>
    And I visit the home page
    And I store 3 todo tasks in session
    When I click on Show details
    And I press the back browser button
    Then I see the 3 todo tasks in todo list

    Examples:
      | Browser           | Version | Strategy  | Platform   |
      | firefox           | 34      | whitelist | Linux      |
      | firefox           | 34      | blacklist | Linux      |
      | chrome            | 38      | whitelist | Linux      |
#       | opera             | 12      | whitelist | Linux      |
#       | safari            | 8       | whitelist | OS X 10.10 |
#       | internet explorer | 11      | whitelist | Windows 7  |
#       | internet explorer | 10      | whitelist | Windows 7  |
#       | internet explorer | 9       | whitelist | Windows 7  |