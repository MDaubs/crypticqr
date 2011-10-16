Feature: User sessions

  Scenario: A visitor receives instructions for starting a session
    When I go to the home page
    Then I see instructions for starting a session

  Scenario: A visitor can set a session password
    When I go to the home page
    And  I set a new session password
    Then I see options for encoding QR codes

  Scenario: A visitor can clear the session password
    When I go to the home page
    And  I set a new session password
    And  I clear the session password
    Then I see instructions for starting a session
