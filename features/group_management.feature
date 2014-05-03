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
    And A list of Mutants
      | Name    |
      | Hellion |
      | Selene  |
      | Trance  |
      | Magus   |
    And A list of groups
      | Name         | Mutants         | Tasks                              |
      | Task Force 1 | Hellion, Trance | Help Tyger Tiger, Destroy Mammomax |
      | Task Force 2 | Selene,  Magus  | Attack Warlock                     |

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
