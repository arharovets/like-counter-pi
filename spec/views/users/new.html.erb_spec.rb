require 'rails_helper'

RSpec.describe 'users/new', type: :view do
  before do
    assign(:user, User.new)
  end

  xit 'renders new user form' do
    skip('Implement it')
  end
end
