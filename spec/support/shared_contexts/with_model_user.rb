RSpec.shared_context 'with model user' do
  with_model :User do
    table do |t|
      t.string :name
      t.string :email
      t.timestamps null: false
    end

    model do
      validates :email, presence: true
    end
  end
end
