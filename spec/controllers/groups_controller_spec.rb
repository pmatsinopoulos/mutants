require 'spec_helper'

describe Mutants::GroupsController do
  describe '#new' do
    it 'instantiates a group empty object' do
      get :new

      expect(assigns(:group)).to be_a(Mutants::Group)
      expect(assigns(:group)).to be_new_record
    end
  end

  describe '#create' do
    context 'when params allow the group to be saved' do
      let(:params) { {name: SecureRandom.hex} }
      it 'creates a group successfully and redirects to edit path' do
        expect do
          post :create, :mutants_group => params
        end.to change { Mutants::Group.count }.by(1)

        created_group = Mutants::Group.last
        expect(response).to redirect_to(edit_group_path(created_group))
        expect(flash[:notice]).to eq('Group has been created successfully!')
      end
    end

    context 'when params do not allow the group to be saved' do
      let(:params) { {name: nil} }
      it 'does not create the group and renders new' do
        expect do
          post :create, :mutants_group => params
        end.to_not change { Mutants::Group.count }

        expect(response.status).to eq(422)
        expect(flash[:alert]).to eq('Group cannot be created')
        assigned_group = assigns(:group)
        expect(assigned_group).to be_a(Mutants::Group)
        expect(assigned_group).to be_a_new_record
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    let(:group) { create :group }
    it 'instantiates a group based on the id in the params' do
      get :edit, :id => group.to_param

      expect(response.status).to eq(200)
      expect(assigns(:group).id).to eq(group.id)
    end
  end
end