require 'spec_helper'

describe Mutants::Mutant do
  subject { build :mutant }
  describe '#name' do
    context 'when is missing' do
      before { subject.name = nil }
      it 'is invalid' do
        subject.valid?
        expect(subject.errors[:name]).to include(invalid_presence_error)
      end
    end

    context 'when name is equal to the name of another mutant' do
      before { create :mutant }
      before { subject.name = Mutants::Mutant.last!.name }
      it 'is invalid' do
        subject.valid?

        expect(subject.errors[:name]).to include invalid_uniqueness_error
      end
    end
  end
end
