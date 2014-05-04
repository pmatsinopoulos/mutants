require 'spec_helper'

describe 'Routing to welcome controller' do
  it 'routes root to index' do
    expect(get: '/').to route_to controller: 'mutants/welcome', action: 'index'
    expect(root_path).to eq('/')
  end
end