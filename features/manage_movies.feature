Feature: Manage movies
  In order to store movies
  A user
  should be able to add and remove movies

  Scenario: Register new movie
    Given I am signed up and confirmed as "email@person.com/password"
    When I sign in as "email@person.com/password"
    And I am on the new movie page
    When I fill in "Title" with "title 1"
    And I fill in "Format" with "format 1"
    And I uncheck "Private"
    And I fill in "Asin" with "asin 1"
    And I press "Create"
    Then I should see "Movie was successfully created"
    And I should see "title 1"
    And I should see "format 1"
    And I should see "false"
    And I should see "asin 1"

  Scenario: Delete movie
    Given I am signed up and confirmed as "email@person.com/password"
    When I sign in as "email@person.com/password"
    Given the following movies:
      |title|format|private|asin|user_id|
      |Title 1|DVD|false|1234|1|
      |Title 2|DVD|false|1234|1|
      |Title 3|DVD|false|1234|1|
      |Title 4|DVD|false|1234|1|
    When I delete the 3rd movie
    Then I should see the following movies:
      |title|format|private|asin|user_id|
      |Title 1|DVD|false|1234|1|
      |Title 2|DVD|false|1234|1|
      |Title 4|DVD|false|1234|1|
