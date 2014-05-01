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

  Scenario: Create a new task
    When I visit the create new task page
     And I fill in the name "Kill Aardwolf"
     And I click on the Save button
    Then I get a confirmation that task has been created successfully

