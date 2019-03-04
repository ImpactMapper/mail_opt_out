RSpec.shared_context 'with an user' do
  let!(:user) do
    User.create!({
      name:  FFaker::Name.name,
      email: FFaker::Internet.email
    })
  end
  let(:user_id) { user.id }
end
