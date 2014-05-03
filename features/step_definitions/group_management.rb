And(/^A list of Mutants$/) do |table|
  data = table.raw
  return if data.empty? || data.size == 1
  i = 1
  mutants = []
  while i < data.size
    mutants << create(:mutant, name: data[i][0])
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
  expect(@page.flash).to eq("Group has been created successfully")
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