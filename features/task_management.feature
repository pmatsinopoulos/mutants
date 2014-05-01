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

  Scenario: Try to create a new task with same name as existing one should fail
    Given A list of tasks
      | Name |
      | Kill Aardwolf |
    When I visit the create new task page
     And I fill in the name "Kill Aardwolf"
     And I click on the Save button
    Then I get an error message

  Scenario: Try to create a new task without name should fail
    When I visit the create new task page
     And I click on the Save button
    Then I get an error message

  Scenario: Open the edit page of an existing task to edit it.
    Given A list of tasks
      | Name |
      | Kill Aardwolf |
     When I visit the page of the task "Kill Aardwolf"
      And I change the name to "Help Aardwolf"
      And I click on Update button
     Then I get a confirmation message that the task has been updated
      And I see the task having the new name "Help Aardwolf"

  @javascript
  Scenario: Delete a task
    Given A list of tasks
      | Name             |
      | Kill Aardwolf    |
      | Help Tyger Tiger |
     When I visit tasks management page
      And I click to delete task "Kill Aardwolf"
      And I confirm the delete action
     Then the task "Kill Aardwolf" does not exist anymore

  Scenario: Search for a task by name
    Given A list of tasks
      | Name             |
      | Kill Aardwolf    |
      | Help Tyger Tiger |
     When I visit tasks management page
      And I fill in the search box with "Aardwolf"
      And I click on the search button
     Then Task list displays all tasks that match "Aardwolf"
