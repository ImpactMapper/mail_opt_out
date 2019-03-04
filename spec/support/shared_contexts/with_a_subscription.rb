RSpec.shared_context 'with a subscription' do
  include_context 'with an user'
  let(:list) { Fabricate.create(:list, name: 'Notification System', number: '42x') }
  let!(:subscription) do
    Fabricate.create(:subscription, user: user, list: list)
  end
end
