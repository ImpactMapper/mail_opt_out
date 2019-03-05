require 'rails_helper'

require 'gibbon'

module MailOptOut
  RSpec.describe Service do
    let(:service) do
      Struct.new(:lists) do
        include MailOptOut::Service
      end.new
    end

    before do
      expect(service).to receive(:lists).and_return(lists)
    end

    let(:lists) do
      [
        {
          id: '42x',
          name: 'A List Name'
        }
      ]
    end

    describe '#sync' do
      context 'list exists by its number' do
        let!(:list) do
          Fabricate.create(:list, number: '42x', name: 'Old Name')
        end

        it 'should update the name' do
          expect {
            service.sync
          }.to change {
            list.reload.name
          }.from('Old Name').to('A List Name').and not_change {
            List.count
          }
        end
      end

      context 'list exists by its name' do
        let!(:list) do
          Fabricate.create(:list, number: nil, name: 'A List Name')
        end

        it 'should set the number' do
          expect {
            service.sync
          }.to change {
            list.reload.number
          }.from(nil).to('42x').and not_change {
            List.count
          }
        end
      end

      context 'list does not exist' do
        it 'should create it' do
          expect {
            service.sync
          }.to change {
            List.count
          }.by(+1)
        end
      end
    end
  end
end
