FactoryGirl.define do
  factory :mutant, :class => 'Mutants::Mutant' do
    name { SecureRandom.hex }
  end
end