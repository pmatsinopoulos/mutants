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
  @task_management_page.wait_for_task_list_items
  expect(@task_management_page).to have_task_list_items
  task_list = @task_management_page.task_list_items

  expect(task_list).to have(@tasks.count).elements
  expect(task_list.first.name).to eq(@tasks.sort.first.name)
  expect(task_list.last.name).to eq(@tasks.sort.last.name)

  expect(task_list.first.id.to_i).to eq(@tasks.sort.first.id)
  expect(task_list.last.id.to_i).to eq(@tasks.sort.last.id)
end