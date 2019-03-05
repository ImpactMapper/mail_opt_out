require 'rails_helper'

require 'gibbon'

module MailOptOut
  RSpec.describe Services::Mailchimp do
    let(:api_key) { '45285254324265220780377042800733-us20' }
    let(:list_id) { '8330ABCd4b' }

    describe '.discoverable?' do
      context 'with env set' do
        before { ENV['MAILCHIMP_API_KEY'] = api_key }

        it { expect(described_class).to be_discoverable }
      end

      context 'without env set' do
        before { ENV['MAILCHIMP_API_KEY'] = nil }

        it { expect(described_class).to_not be_discoverable }
      end
    end

    let(:options) { { api_key: api_key } }

    subject { described_class.new(options) }

    describe '#lists' do
      it do
        VCR.use_cassette('lists') do
          expect(subject.lists).to eql([{ id: '6ce123c396', name: 'Notification System' }])
        end
      end
    end

    context 'with a list' do
      let!(:list) { Fabricate.create(:list, name: list_name, number: list_id) }

      describe '#opt_out' do
        context 'when opted in' do
          let(:list_name) { 'Notifcation System' }
          let(:email)     { 'existing@example.org' }

          before do
            expect(subject).to receive(:get_member).and_return({ 'id' => '5d3f7d8e534a123e3029a3f3b9761de5' })
          end

          it 'should update the member' do
            VCR.use_cassette('update_existing_member') do
              expect(subject.opt_out(email: email, list_name: list_name)).to be_truthy
            end
          end
        end
      end

      describe '#opt_in' do
        context 'no member yet' do
          let(:list_name) { 'Notifcation System' }
          let(:email)     { 'unknown@example.org' }

          it 'should opted in the member' do
            VCR.use_cassette('create_unexisting_member') do
              expect(subject.opt_in(email: email, list_name: list_name)).to be_truthy
            end
          end
        end
      end
    end

    describe '#create_member' do
      context 'none existing member' do
        let(:email) { 'unknown@example.org' }

        it do
          VCR.use_cassette('create_unexisting_member') do
            expect(subject.send(:create_member, email: email, list_id: list_id)).to be_truthy
          end
        end
      end

      context 'an existing member' do
        let(:email) { 'existing@example.org' }

        it do
          VCR.use_cassette('create_existing_member') do
            expect(subject.send(:create_member, email: email, list_id: list_id)).to be_falsy
          end
        end
      end
    end

    describe '#get_member' do
      context 'none existing member' do
        let(:email) { 'unknown@example.org' }

        it do
          VCR.use_cassette('get_unexisting_member') do
            expect(subject.send(:get_member, email: email, list_id: list_id)).to be_nil
          end
        end
      end

      context 'an existing member' do
        let(:email) { 'existing@example.org' }

        it do
          VCR.use_cassette('get_existing_member') do
            expect(subject.send(:get_member, email: email, list_id: list_id)).to eql(
              {
                email: 'existing@example.org',
                id: '5d3f7d8e534a123e3029a3f3b9761de5',
                status: 'subscribed'
              }
            )
          end
        end
      end
    end

    describe '#update_member' do
      context 'none existing member' do
        let(:member_id) { '5d3f7d8e534axxxe3029a3f3b9761de5' }

        it do
          VCR.use_cassette('update_unexisting_member') do
            expect(subject.send(:update_member, list_id: list_id, member_id: member_id)).to be_falsy
          end
        end
      end

      context 'an existing member' do
        let(:member_id) { '5d3f7d8e534a123e3029a3f3b9761de5' }

        it do
          VCR.use_cassette('update_existing_member') do
            expect(subject.send(:update_member, list_id: list_id, member_id: member_id)).to be_truthy
          end
        end
      end
    end
  end
end
