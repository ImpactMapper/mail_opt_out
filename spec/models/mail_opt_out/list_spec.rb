require 'rails_helper'

module MailOptOut
  RSpec.describe List, type: :model do
    let(:valid_attributes) { Fabricate.attributes_for(:list) }
    let(:list)             { List.new(attributes) }

    context 'valid attributes' do
      let(:attributes) { valid_attributes }

      it do
        expect(list).to be_valid
        expect {
          list.save!
        }.to_not raise_error
      end
    end

    context 'with an list' do
      let(:attributes) { valid_attributes }

      before { list.save! }

      context 'attempt create a duplicate' do
        let(:duplicate) { List.new(valid_attributes.merge(name: valid_attributes[:name].upcase)) }

        it do
          expect(duplicate).to_not be_valid
          expect(duplicate.errors.messages).to eql({ name: ['has already been taken'] })
        end
      end
    end
  end
end
