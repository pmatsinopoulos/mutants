require 'spec_helper'

describe Mutants::Group do
  subject { build :group }
  describe '#name' do
    context 'when name is missing' do
      before { subject.name = nil }
      it 'is invalid' do
        subject.valid?

        expect(subject.errors[:name]).to include invalid_presence_error
      end
    end

    context 'when name is equal to the name of another group' do
      before { create :group }
      before { subject.name = Mutants::Group.last!.name }
      it 'is invalid' do
        subject.valid?

        expect(subject.errors[:name]).to include invalid_uniqueness_error
      end
    end
  end

  describe '#mutants' do
    context 'when group contains mutants' do
      let(:mutants) { [create(:mutant), create(:mutant)] }
      before do
        mutants.each { |m| subject.mutants << m }
        subject.save!
      end
      context 'when group is destroyed' do
        before do
          subject.destroy
        end
        it 'corresponding mutants are freed' do
          expect(mutants.all? {|m| m.reload and m.group_id.nil?}).to be_true
        end
      end
    end
  end

  describe '#tasks' do
    context 'when group contains tasks' do
      let(:tasks) { [create(:task), create(:task)] }
      before do
        tasks.each { |t| subject.tasks << t }
        subject.save!
      end
      context 'when group is destroyed' do
        before do
          subject.destroy
        end
        it 'corresponding tasks are freed' do
          expect(tasks.all? {|t| t.reload and t.group_id.nil?}).to be_true
        end
      end
    end
  end
end