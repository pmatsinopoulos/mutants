Feature: Task Management
  As Professor Xavier
  I want to be able to manage tasks
  So that I can assign them to Mutants

  Scenario: View page with list of tasks
    Given A list of tasks
      | Name             |
      | Kill Aardwolf    |
      | Help Tyger Tiger |
    When I visit tasks management page
    Then I see the list of tasks
