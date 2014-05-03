require 'spec_helper'

describe Mutants::GroupsController do
  describe '#new' do
    it 'instantiates a group empty object' do
      get :new

      expect(assigns(:group)).to be_a(Mutants::Group)
      expect(assigns(:group)).to be_new_record
    end
  end
end