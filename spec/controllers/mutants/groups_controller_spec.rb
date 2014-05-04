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
        expect(response).to redirect_to(edit_group_url(created_group))
        expect(flash[:success]).to eq('Group has been created successfully!')
      end
    end

    context 'when params do not allow the group to be saved' do
      let(:params) { {name: nil} }
      it 'does not create the group and renders new' do
        expect do
          post :create, :mutants_group => params
        end.to_not change { Mutants::Group.count }

        expect(response.status).to eq(422)
        expect(flash[:error]).to eq('Group cannot be created')
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

  describe '#update' do
    let(:group) { create :group }
    let(:params) { {name: new_name} }
    context 'when update params are ok' do
      let(:new_name) { SecureRandom.hex }
      it 'can update the name of a group' do
        put :update, id: group.to_param, mutants_group: params

        expect(response).to redirect_to(edit_group_url(group))
        expect(group.reload.name).to eq(new_name)
      end
    end

    context 'when update params are not ok' do
      let(:new_name) { nil }
      it 'fails to update and renders edit' do
        put :update, id: group.to_param, mutants_group: params

        expect(response.status).to eq(422)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#index' do
    context 'given a list of groups' do
      let(:groups) do
        [create(:group), create(:group)]
      end
      let(:groups_matching) { groups.select {|t| t.name.include?(query_string)} }

      context 'when querying with part of the name of one of the groups' do
        let(:query_string) { groups.last.name[1, 3] }
        it 'brings the group whose name includes the query string' do
          get :index, :q => query_string

          assigned_groups = assigns(:groups).to_a
          expect(assigned_groups).to be_present

          expect(assigned_groups.size).to eq(groups_matching.size)
          expect(assigned_groups.map{|g| g.name}.sort).to eq(groups_matching.map{|g| g.name}.sort)
        end
      end

      context 'when querying with string that does not match any group' do
        let(:query_string) { SecureRandom.hex }
        it 'brings an empty group list' do

          get :index, :q => query_string

          assigned_groups = assigns(:groups).to_a
          expect(assigned_groups).to be_blank

          expect(assigned_groups.size).to eq(groups_matching.size)
          expect(assigned_groups.map{|g| g.name}.sort).to eq(groups_matching.map{|g| g.name}.sort)
        end
      end

      context 'when querying without any string' do
        before { groups }
        let(:groups_matching) { groups }
        it 'brings all the groups' do
          get :index

          assigned_groups = assigns(:groups).to_a
          expect(assigned_groups).to be_present

          expect(assigned_groups.size).to eq(groups_matching.size)
          expect(assigned_groups.map{|g| g.name}.sort).to eq(groups_matching.map{|g| g.name}.sort)
        end
      end
    end
  end

  describe '#destroy' do
    context 'when it succeeds' do
      it 'destroys the group with id given and redirects to group list page' do
        group = create :group

        expect do
          delete :destroy, id: group.to_param
        end.to change { Mutants::Group.count }.by(-1)

        expect(response).to redirect_to(groups_url)
        expect(flash[:success]).to eq('Group has been successfully deleted!')
      end
    end

    context 'when it fails' do
      before { allow_any_instance_of(Mutants::Group).to receive(:destroy).and_return(false) }
      it 'redirects to groups list page' do
        group = create :group
        expect do
          delete :destroy, id: group.to_param
        end.to_not change { Mutants::Group.count }

        expect(response).to redirect_to(groups_url)
      end
    end
  end
end