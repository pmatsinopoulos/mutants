FactoryGirl.define do
  factory :task, :class => 'Mutants::Task' do
    name { SecureRandom.hex }
  end
end