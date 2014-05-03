FactoryGirl.define do
  factory :group, class: 'Mutants::Group' do
    name { SecureRandom.hex }
  end
end