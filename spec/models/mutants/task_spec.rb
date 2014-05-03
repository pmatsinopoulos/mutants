require 'spec_helper'

describe Mutants::Task do
  subject { build :task }
  describe '#name' do
    context 'when is missing' do
      before { subject.name = nil }
      it 'is invalid' do
        subject.valid?
        expect(subject.errors[:name]).to include(invalid_presence_error)
      end
    end

    context 'when name is equal to the name of another task' do
      before { create :task }
      before { subject.name = Mutants::Task.last!.name }
      it 'is invalid' do
        subject.valid?

        expect(subject.errors[:name]).to include invalid_uniqueness_error
      end
    end
  end
end
