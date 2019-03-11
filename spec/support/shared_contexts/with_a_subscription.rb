RSpec.shared_context 'with a subscription' do
  include_context 'with an user'
  let(:list) { Fabricate.create(:list, name: 'Notification System', number: '42x', published: true) }
  let!(:subscription) do
    Fabricate.create(:subscription, user: user, list: list)
  end
end
