# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end

    # Other tests for the index action
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end

    # Other tests for the new action
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:task) }
    let(:invalid_attributes) { attributes_for(:task, title: nil) }

    context 'with valid attributes' do
      it 'creates a new task' do
        expect {
          post :create, params: { task: valid_attributes }, format: :turbo_stream
        }.to change(Task, :count).by(1)
      end

      it 'renders the create_success turbo stream response' do
        post :create, params: { task: valid_attributes }, format: :turbo_stream
        expect(response).to render_template('tasks/_tasks_list')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new task' do
        expect {
          post :create, params: { task: invalid_attributes }, format: :turbo_stream
        }.not_to change(Task, :count)
      end

      it 'renders the create_error turbo stream response' do
        post :create, params: { task: invalid_attributes }, format: :turbo_stream
        expect(response).to render_template('tasks/_tasks_list')
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: task.id }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end

    # Other tests for the edit action
  end

  describe 'PATCH #update' do
    let(:valid_attributes) { attributes_for(:task, title: 'Updated Title') }
    let(:invalid_attributes) { attributes_for(:task, title: nil) }

    context 'with valid attributes' do
      it 'updates the task' do
        patch :update, params: { id: task.id, task: valid_attributes }, format: :turbo_stream
        task.reload
        expect(task.title).to eq('Updated Title')
      end

      it 'renders the update_success turbo stream response' do
        patch :update, params: { id: task.id, task: valid_attributes }, format: :turbo_stream
        expect(response).to render_template('tasks/_tasks_list')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the task' do
        patch :update, params: { id: task.id, task: invalid_attributes }, format: :turbo_stream
        task.reload
        expect(task.title).not_to eq(nil)
      end

      it 'renders the update_error turbo stream response' do
        patch :update, params: { id: task.id, task: invalid_attributes }, format: :turbo_stream
        expect(response).to render_template('tasks/_tasks_list')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the task' do
      expect {
        delete :destroy, params: { id: task.id }, format: :turbo_stream
      }.to change(Task, :count).by(0)

      expect(Task.exists?(task.id)).to be_falsey
    end

    it 'renders the destroy_success turbo stream response' do
      delete :destroy, params: { id: task.id }, format: :turbo_stream
      expect(response).to render_template('tasks/_tasks_list')
    end
  end

  describe 'GET #task_audits' do
    before { task.update(title: 'test123') }

    it 'assigns @task_audits with task audits' do
      get :task_audits, params: { id: task.id }
      expect(assigns(:task_audits)).to eq(task.audits.where(action: 'update'))
    end

    it 'renders the task_audits template' do
      get :task_audits, params: { id: task.id }
      expect(response).to render_template(:task_audits)
    end
  end
end
