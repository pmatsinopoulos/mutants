require 'spec_helper'

describe Mutants::TasksController do
  describe '#index' do
    context 'given a list of tasks' do
      let(:tasks) do
        [create(:task), create(:task)]
      end
      let(:tasks_matching) { tasks.select {|t| t.name.include?(query_string)} }

      context 'when querying with part of the name of one of the tasks' do
        let(:query_string) { tasks.last.name[1, 3] }
        it 'brings the task whose name includes the query string' do
          get :index, :q => query_string

          assigned_tasks = assigns(:tasks).to_a
          expect(assigned_tasks).to be_present

          expect(assigned_tasks.size).to eq(tasks_matching.size)
          expect(assigned_tasks.map{|t| t.name}.sort).to eq(tasks_matching.map{|t| t.name}.sort)
        end
      end

      context 'when querying with string that does not match any task' do
        let(:query_string) { SecureRandom.hex }
        it 'brings an empty task list' do

          get :index, :q => query_string

          assigned_tasks = assigns(:tasks).to_a
          expect(assigned_tasks).to be_blank

          expect(assigned_tasks.size).to eq(tasks_matching.size)
          expect(assigned_tasks.map{|t| t.name}.sort).to eq(tasks_matching.map{|t| t.name}.sort)
        end
      end

      context 'when querying without any string' do
        before { tasks }
        let(:tasks_matching) { tasks }
        it 'brings all the tasks' do
          get :index

          assigned_tasks = assigns(:tasks).to_a
          expect(assigned_tasks).to be_present

          expect(assigned_tasks.size).to eq(tasks_matching.size)
          expect(assigned_tasks.map{|t| t.name}.sort).to eq(tasks_matching.map{|t| t.name}.sort)
        end
      end
    end
  end

  describe '#new' do
    it 'instantiates a task empty object' do
      get :new

      expect(assigns(:task)).to be_a(Mutants::Task)
      expect(assigns(:task)).to be_new_record
    end
  end

  describe '#create' do
    context 'when params allow the task to be saved' do
      let(:params) { {name: SecureRandom.hex} }
      it 'creates a task successfully and redirects to edit path' do
        expect do
          post :create, :mutants_task => params
        end.to change { Mutants::Task.count }.by(1)

        created_task = Mutants::Task.last
        expect(response).to redirect_to(edit_task_path(created_task))
        expect(flash[:notice]).to eq('Task has been created successfully!')
      end
    end

    context 'when params do not allow the task to be saved' do
      let(:params) { {name: nil} }
      it 'does not create the group and renders new' do
        expect do
          post :create, :mutants_task => params
        end.to_not change { Mutants::Task.count }

        expect(response.status).to eq(422)
        expect(flash[:alert]).to eq('Cannot create task!')
        assigned_task = assigns(:task)
        expect(assigned_task).to be_a(Mutants::Task)
        expect(assigned_task).to be_a_new_record
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    let(:task) { create :task }
    it 'instantiates a task based on the id in the params' do
      get :edit, :id => task.to_param

      expect(response.status).to eq(200)
      expect(assigns(:task).id).to eq(task.id)
    end
  end

  describe '#update' do
    let(:task) { create :task }
    let(:params) { {name: new_name} }
    context 'when update params are ok' do
      let(:new_name) { SecureRandom.hex }
      it 'can update the name of a task' do
        put :update, id: task.to_param, mutants_task: params

        expect(response).to redirect_to(edit_task_path(task))
        expect(task.reload.name).to eq(new_name)
      end
    end

    context 'when update params are not ok' do
      let(:new_name) { nil }
      it 'fails to update and renders edit' do
        put :update, id: task.to_param, mutants_task: params

        expect(response.status).to eq(422)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    context 'when it succeeds' do
      it 'destroys the task with id given and redirects to task list page' do
        task = create :task

        expect do
          delete :destroy, id: task.to_param
        end.to change { Mutants::Task.count }.by(-1)

        expect(response).to redirect_to(tasks_path)
        expect(flash[:notice]).to eq('Task has been successfully deleted!')
      end
    end

    context 'when it fails' do
      before { allow_any_instance_of(Mutants::Task).to receive(:destroy).and_return(false) }
      it 'redirects to tasks list page' do
        task = create :task
        expect do
          delete :destroy, id: task.to_param
        end.to_not change { Mutants::Task.count }

        expect(response).to redirect_to(tasks_path)
      end
    end
  end

end