Given(/^A list of tasks$/) do |table|
  data = table.raw
  return if data.empty? || data.size == 1
  i = 1
  @tasks = []
  while i < data.size
    @tasks << create(:task, name: data[i][0])
    i += 1
  end
  expect(@tasks.count).to eq(data.size - 1)
end

When(/^I visit tasks management page$/) do
  @task_management_page = Mutants::Pages::TaskManagement.new
  @task_management_page.load
end

Then(/^I see the list of tasks$/) do
  pending # express the regexp above with the code you wish you had
end