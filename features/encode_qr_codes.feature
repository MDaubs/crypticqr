Feature: Encode and decode QR codes

  Scenario: A visitor who has set a session password can encode a QR code
    Given I have set a session password of "1234"
    When  I go to the home page
    And   I complete the encode QR code form with the text "Testing 1, 2, 3."
    Then  I should see an encoded and encrypted QR code for the text "Testing 1, 2, 3."

  Scenario: A visitor who has not set a session password cannot decode a QR code
    When  I go to the decode page for a QR code generated with the password "1234" and text "Hello World" with no session password
    Then  I get an error

  Scenario: A visitor cannot decode a QR code that doesn't match the session password
    When  I go to the decode page for a QR code generated with the password "1234" and text "Hello World" with the session password "5432"
    Then  I get an error

  Scenario: A visitor who has set a session password can decode a QR code
    When  I go to the decode page for a QR code generated with the password "1234" and text "Hello World" with the session password "1234"
    Then  I see "Hello World"
