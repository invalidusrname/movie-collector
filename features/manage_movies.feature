Feature: Manage movies
  In order to store movies
  A user
  should be able to add and remove movies

  Scenario: Register new movie
    Given I am signed up and confirmed as "email@person.com/password"
    When I sign in as "email@person.com/password"
    And I am on the new movie page
    When I fill in "UPC" with "1234567"
    When I fill in "Title" with "Sample Title"
    And I select "DVD" from "Format"
    And I press "Create"
    Then I should see "Movie was successfully created"
    And I should see "Sample Title"
    And I should see "DVD"

  # FIXME: failing scenario
  # Scenario: Delete movie
  #   Given I am signed up and confirmed as "email@person.com/password"
  #   When I sign in as "email@person.com/password"
  #   Given the following movies:
  #     |title|format|asin|upc|
  #     |Title 1|DVD|1234|1234|
  #     |Title 2|DVD|1234|1234|
  #     |Title 3|DVD|1234|1234|
  #     |Title 4|DVD|1234|1234|
  #   When I delete the 3rd movie
  #   Then I should see the following movies:
  #     |title|format|asin|upc|
  #     |Title 1|DVD|1234|1234|
  #     |Title 2|DVD|1234|1234|
  #     |Title 4|DVD|1234|1234|
