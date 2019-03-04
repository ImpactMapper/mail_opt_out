RSpec.shared_context 'with a subscription' do
  include_context 'with an user'
  let!(:subscription) do
    Fabricate.create(:subscription, user: user, list: 'Notification System')
  end
end