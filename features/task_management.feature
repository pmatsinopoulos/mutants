Feature: Task Management
  As Professor Xavier
  I want to be able to manage tasks
  So that I can assign them to Mutants

  Background:
    Given A list of tasks
      | Name             |
      | Kill Aardwolf    |
      | Help Tyger Tiger |

  Scenario: View page with list of tasks
    When I visit tasks management page
    Then I see the list of tasks

  Scenario: Create a new task
    When I visit the create new task page
     And I fill in the name "Help Aardwolf"
     And I click on the Save button
    Then I get a confirmation that task has been created successfully

  Scenario: Try to create a new task with same name as existing one should fail
    When I visit the create new task page
     And I fill in the name "Kill Aardwolf"
     And I click on the Save button
    Then I get an error message

  Scenario: Try to create a new task without name should fail
    When I visit the create new task page
     And I click on the Save button
    Then I get an error message

  Scenario: Open the edit page of an existing task to edit it.
     When I visit the page of the task "Kill Aardwolf"
      And I change the name to "Help Aardwolf"
      And I click on Update button
     Then I get a confirmation message that the task has been updated
      And I see the task having the new name "Help Aardwolf"

  @javascript
  Scenario: Delete a task
     When I visit tasks management page
      And I click to delete task "Kill Aardwolf"
      And I confirm the delete action
     Then the task "Kill Aardwolf" does not exist anymore

  Scenario: Search for a task by name
     When I visit tasks management page
      And I fill in the search box with "Aardwolf"
      And I click on the search button
     Then Task list displays all tasks that match "Aardwolf"

  Scenario: I can visit the new task page from task list page
    Given I visit tasks management page
     When I click on new task link
     Then I am on the new task page

  Scenario: I can visit task list page from task edit page
     When I visit the page of the task "Help Tyger Tiger"
      And I click on the task list link
     Then I am on the task list page

  Scenario: I can visit task list page from new task page
    When I visit the create new task page
    And I click on the task list link
    Then I am on the task list page

  Scenario: When I am on the task list page I can click on the name of a task and that would take me to the edit task page
    When I visit tasks management page
     And I click on task with name "Help Tyger Tiger"
    Then I see the edit page of the task with name "Help Tyger Tiger"

  Scenario: When I visit the Task management page, I see the number of Mutants assigned to each Task
    When I visit tasks management page
    Then For each Task I see the number of Mutants inside
