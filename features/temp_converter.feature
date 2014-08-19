@javascript
Feature: Temperature converter

  Scenario: Opening the page
    When on the page
    Then should see initial page

    When click within "#lower_display"
    Then should see centigrade marked

    When enter 212 in Fahrenheit
    Then should see "100.0" in Centigrade

    When enter 0 in Centigrade
    Then should see "32.0" in Fahrenheit

    When enter 50 in Centigrade
    Then should see "122.0" in Fahrenheit

    When enter c
    Then should see nothing

    When enter 32 in Fahrenheit
    Then should see "0.0" in Centigrade
    When enter -
    Then should see "-32" in Fahrenheit

    When enter minus at the end of a Fahrenheit number
    Then minus is prepended to both Fahrenheit and Centigrade numbers

    When enter minus at the end of a Centigrade number
    Then minus is prepended to both Centigrade and Fahrenheit numbers

    When enter minus multiple times
    Then only one minus shows

    When enter decimal-point multiple times
    Then only one decimal-point shows

    When enter minus at the beginning of a Fahrenheit field
    Then no calculation is done in the Centigrade field

    When enter minus at the beginning of a Centigrade field
    Then no calculation is done in the Fahrenheit field

    When enter minus-dot at the beginning of a Fahrenheit field
    Then minus-dot is copied to the Centigrade field

    When enter minus-dot at the beginning of a Centigrade field
    Then minus-dot is copied to  the Fahrenheit field
