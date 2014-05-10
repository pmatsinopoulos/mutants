Feature: Group Management
  As Professor Xavier
  I want to be able to build up a Group of Mutants
  and assign Tasks to them.

  Background:
    Given A list of tasks
      | Name              |
      | Kill Aardwolf     |
      | Help Tyger Tiger  |
      | Destroy Mammomax  |
      | Attack Warlock    |
      | Save Starbolt     |
      | Save Selene       |
    And A list of Mutants
      | Name     |
      | Hellion  |
      | Selene   |
      | Trance   |
      | Magus    |
      | Starbolt |
    And A list of groups
      | Name         | Mutants         | Tasks                              |
      | Task Force 1 | Hellion, Trance | Help Tyger Tiger, Destroy Mammomax |
      | Task Force 2 | Selene,  Magus  | Attack Warlock, Save Starbolt      |
      | Super Powers | Starbolt        | Save Selene                        |

  Scenario: Create a new Group of Mutants and Assign Tasks to Them
    When I visit the page to create a new Group
     And I fill in the name of the Group with "Super G-I"
     And I add the following Mutants to the Group
       | Name    |
       | Hellion |
       | Selene  |
     And I add the following Tasks to the Group
       | Name              |
       | Help Tyger Tiger  |
       | Destroy Mammomax  |
    When I click the create group button
    Then I see a message that group has been created successfully
     And New group has the following Mutants inside
       | Name    |
       | Hellion |
       | Selene  |
     And New group has been assigned the following Tasks
       | Name              |
       | Help Tyger Tiger  |
       | Destroy Mammomax  |

  Scenario: When I visit the list of Groups I see the existing Groups and the Number of Mutants and Tasks Assigned
    When I visit groups management page
    Then I see the list of groups
     And For each group I see the number of Mutants inside
     And The number of Tasks assigned

  Scenario: When I visit the list of Groups I can click on the name of a Group and I can go to edit the Group
    When I visit groups management page
     And I click on the name of the Group "Task Force 2"
    Then I can see the edit page of this Group

  Scenario: I visit the edit page of a Group and I can change its name
    When I visit the edit page of the Group "Task Force 2"
     And I change its name to "Task Force 3"
     And I click the button update
    Then The name of the group has changed to "Task Force 3"

  Scenario: I visit the edit page of a Group and I can remove a Mutant
    When I visit the edit page of the Group "Task Force 2"
     And I remove the Mutant "Selene"
     And I click the button update
    Then "Task Force 2" remains only with Mutant "Magus"

  Scenario: I visit the edit page of a Group and I can add a Mutant
    When I visit the edit page of the Group "Task Force 2"
     And I add the Mutant "Starbolt"
     And I click the button update
    Then "Task Force 2" has the mutants
      | Name     |
      | Selene   |
      | Magus    |
      | Starbolt |

  Scenario: I visit the edit page of a Group and I can remove a Task
    When I visit the edit page of the Group "Task Force 2"
     And I remove the Task "Attack Warlock"
     And I click the button update
    Then "Task Force 2" remains only with Task "Save Starbolt"

  Scenario: I visit the edit page of a Group and I can add a Task
    When I visit the edit page of the Group "Task Force 2"
     And I add the Task "Destroy Mammomax"
     And I click the button update
    Then "Task Force 2" has the Tasks
      | Name             |
      | Destroy Mammomax |
      | Attack Warlock   |
      | Save Starbolt    |

  Scenario: I visit the edit page of a Group and I can go to list of Groups
    When I visit the edit page of the Group "Task Force 2"
     And I click on Groups link
    Then I am on the Groups management page

  Scenario: I visit the Groups Management page and I can go to creation of new Group
    When I visit groups management page
     And I click on create new Group link
    Then I am on the create new Group page

  @javascript
  Scenario: I visit the Groups Management page and I can delete a Group
    When I visit groups management page
     And I click on the delete link for the Group "Task Force 2"
     And I confirm the delete action
    Then I get a confirmation message that the Group has been deleted
     And "Task Force 2" does not exist anymore

  Scenario: Search for a Group by name
    When I visit groups management page
     And I fill in the Groups search box with "Force"
     And I click on the search button
    Then Group list displays all groups that match "Force"

  @javascript
  Scenario: I want to be able to create a Task from within Group Edit page without leaving Group Edit page
    When I visit the edit page of the Group "Task Force 1"
     And I click on the New Task Link
    Then I can input the details of the new Task
     And I can save the new Task
     And I can see the new Task as selected in the list of available Tasks on Group edit page
     And I click the button update
    Then The new Task is associated to the particular Group
<<<<<<< HEAD

  Scenario: I want to be able to create a Task from within Group New page without leaving Group New page
    When I visit the page to create a new Group
     And I click on the New Task Link
    Then I can input the details of the new Task
     And I can save the new Task
     And I can see the new Task in the list of available Tasks on Group new page
=======
>>>>>>> d2912d4... Scenario: I want to be able to create a Task from within Group Edit page without leaving Group Edit page
     And The new Task is already selected
     And When I save the Group
    Then The new Task is associated to the particular Group
