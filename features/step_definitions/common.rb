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
