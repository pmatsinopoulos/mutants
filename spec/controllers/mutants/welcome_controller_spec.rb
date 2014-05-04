require 'spec_helper'

describe Mutants::WelcomeController do
  describe '#index' do
    it 'renders on welcome layout' do
      get :index

      expect(response.status).to eq(200)
      expect(response).to render_template 'mutants/welcome/index'
      expect(response).to render_template 'layouts/application'
    end
  end
end