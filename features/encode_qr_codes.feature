Feature: Encode QR codes

  Scenario: A visitor who has set a session password can encode a QR code
    Given I have set a session password
    When I go to the home page
    And  I complete the encode QR code form with the text "Testing 1, 2, 3."
    Then I should see an encoded and encrypted QR code for the text "Testing 1, 2, 3."
