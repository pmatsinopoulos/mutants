And(/^A list of Mutants$/) do |table|
  data = table.raw
  return if data.empty? || data.size == 1
  i = 1
  mutants = []
  while i < data.size
    mutants << create(:mutant, name: data[i][0].strip)
    i += 1
  end
  expect(mutants.count).to eq(data.size - 1)
end

When(/^I visit the page to create a new Group$/) do
  @page = Mutants::Pages::NewGroup.new
  @page.load
end

And(/^I fill in the name of the Group with "(.*?)"$/) do |group_name|
  @page.name.set group_name
end

And(/^I add the following Mutants to the Group$/) do |table|
  data = table.raw
  return if data.empty? || data.size == 1
  i = 1
  mutants_to_add = []
  while i < data.size
    mutants_to_add << data[i][0]
    i += 1
  end
  expect(mutants_to_add.size).to eq(data.size - 1)

  mutants_to_add.map {|m| @page.mutants.select(m) }
end

And(/^I add the following Tasks to the Group$/) do |table|
  data = table.raw
  return if data.empty? || data.size == 1
  i = 1
  tasks_to_add = []
  while i < data.size
    tasks_to_add << data[i][0]
    i += 1
  end
  expect(tasks_to_add.size).to eq(data.size - 1)

  tasks_to_add.map {|t| @page.tasks.select(t) }
end

When(/^I click the create group button$/) do
  @page.create_button.click
end

Then(/^I see a message that group has been created successfully$/) do
  @page = Mutants::Pages::EditGroup.new
  expect(@page).to be_displayed
  expect(@page.flash).to include("Group has been created successfully!")
  @group = Mutants::Group.last
end

And(/^New group has the following Mutants inside$/) do |table|
  data = table.raw
  return if data.empty? || data.size == 1
  data.shift # remove header
  expect(@group.mutants.map{|m| m.name}.sort).to eq(data.map{|d| d[0]}.sort)
end

And(/^New group has been assigned the following Tasks$/) do |table|
  data = table.raw
  return if data.empty? || data.size == 1
  data.shift # remove header
  expect(@group.tasks.map{|t| t.name}.sort).to eq(data.map{|d| d[0]}.sort)
end

And(/^A list of groups$/) do |table|
  data = table.raw
  data.shift # remove header
  @groups = []
  data.each do |row|
    name_of_group = row[0]
    mutants = row[1]
    tasks = row[2]

    group = Mutants::Group.new

    group.name       = name_of_group.strip
    group.mutant_ids = mutants.split(',').map{|name| Mutants::Mutant.find_by_name!(name.strip).id }
    group.task_ids   = tasks.split(',').map{|name| Mutants::Task.find_by_name!(name.strip).id }
    group.save!

    @groups << group
  end
end

When(/^I visit groups management page$/) do
  @page = Mutants::Pages::GroupManagement.new
  @page.load
end

Then(/^I see the list of groups$/) do
  @groups.sort {|a,b| a.name <=> b.name}.each_with_index do |group, index|
    expect(@page.group_list_items[index].name).to eq(group.name)
  end
end

And(/^For each group I see the number of Mutants inside$/) do
  @groups.sort {|a,b| a.name <=> b.name}.each_with_index do |group, index|
    expect(@page.group_list_items[index].number_of_mutants).to eq(group.mutants.count)
  end
end

And(/^The number of Tasks assigned$/) do
  @groups.sort {|a,b| a.name <=> b.name}.each_with_index do |group, index|
    expect(@page.group_list_items[index].number_of_tasks).to eq(group.tasks.count)
  end
end

And(/^I click on the name of the Group "(.*?)"$/) do |group_name|
  @group_name = group_name # will need that on the next step
  @page.group_list_items.select {|li| li.name == @group_name}.first.edit_page.click
end

Then(/^I can see the edit page of this Group$/) do
  @page = Mutants::Pages::EditGroup.new
  expect(@page).to be_displayed
  expect(@page.name.value).to eq(@group_name)
end

When(/^I visit the edit page of the Group "(.*?)"$/) do |group_name|
  @page = Mutants::Pages::EditGroup.new
  @group = Mutants::Group.find_by_name!(group_name)
  @page.load id: @group.id
end

And(/^I change its name to "(.*?)"$/) do |new_name|
  @page.name.set new_name
end

And(/^I click the button update$/) do
  @page.update.click
end

Then(/^The name of the group has changed to "(.*?)"$/) do |group_name|
  expect(Mutants::Group.find_by_name!(group_name).id).to eq(@group.id)
end

And(/^I remove the Mutant "(.*?)"$/) do |mutant_name|
  @page.mutants.unselect mutant_name
end

Then(/^"(.*?)" remains only with Mutant "(.*?)"$/) do |group_name, mutant_name|
  group = Mutants::Group.find_by_name!(group_name)
  expect(group.mutants.count).to eq(1)
  expect(group.mutants.first.name).to eq(mutant_name)
end

And(/^I add the Mutant "(.*?)"$/) do |mutant_name|
  @page.mutants.select mutant_name
end

Then(/^"(.*?)" has the mutants$/) do |group_name, table|
  group = Mutants::Group.find_by_name! group_name
  data = table.raw
  data.shift # remove header
  expect(group.mutants.map {|m| m.name}.sort).to eq(data.map{|d| d[0].strip}.sort)
end

And(/^I remove the Task "(.*?)"$/) do |task_name|
  @page.tasks.unselect task_name
end

Then(/^"(.*?)" remains only with Task "(.*?)"$/) do |group_name, task_name|
  group = Mutants::Group.find_by_name!(group_name)
  expect(group.tasks.count).to eq(1)
  expect(group.tasks.first.name).to eq(task_name)
end

And(/^I add the Task "(.*?)"$/) do |task_name|
  @page.tasks.select task_name
end

Then(/^"(.*?)" has the Tasks$/) do |group_name, table|
  group = Mutants::Group.find_by_name! group_name
  data = table.raw
  data.shift # remove header
  expect(group.tasks.map{|t| t.name}.sort).to eq(data.map{|d| d[0].strip}.sort)
end

And(/^I click on Groups link$/) do
  @page.groups.click
end

Then(/^I am on the Groups management page$/) do
  @page = Mutants::Pages::GroupManagement.new
  expect(@page).to be_displayed
end

And(/^I click on create new Group link$/) do
  @page.create_new_group.click
end

Then(/^I am on the create new Group page$/) do
  @page = Mutants::Pages::NewGroup.new
  expect(@page).to be_displayed
end

And(/^I click on the delete link for the Group "(.*?)"$/) do |group_name|
  @page = Mutants::Pages::GroupManagement.new
  @group = Mutants::Group.find_by_name(group_name)
  group = @page.group_list_items.select {|gli| gli.id == @group.id}.first
  group.delete.click
end

Then(/^I get a confirmation message that the Group has been deleted$/) do
  expect(@page.flash).to include('Group has been successfully deleted!')
end

And(/^"(.*?)" does not exist anymore$/) do |group_name|
  expect(Mutants::Group.where(:name => group_name).count).to be_zero
end

And(/^I fill in the Groups search box with "(.*?)"$/) do |keyword|
  @page = Mutants::Pages::GroupManagement.new
  @page.search_box.set keyword
end

Then(/^Group list displays all groups that match "(.*?)"$/) do |keyword|
  @page.wait_for_group_list_items
  expect(@page).to have_group_list_items
  group_list = @page.group_list_items

  groups_matching = Mutants::Group.where("name like ?", "%#{keyword}%").order(:name).all.map{|g| {:name => g.name, :id => g.id}}

  expect(group_list).to have(groups_matching.count).elements
  expect(group_list.first.name).to eq(groups_matching.first[:name])
  expect(group_list.last.name).to eq(groups_matching.last[:name])

  expect(group_list.first.id).to eq(groups_matching.first[:id])
  expect(group_list.last.id).to eq(groups_matching.last[:id])
end

And(/^I click on the New Task Link$/) do
  @page.new_task_link.click
end