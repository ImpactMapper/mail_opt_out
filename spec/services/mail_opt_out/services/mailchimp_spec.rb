require 'rails_helper'

require 'gibbon'

module MailOptOut
  RSpec.describe Services::Mailchimp do
    let(:api_key) { '45285254324265220780377042800733-us20' }

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

    describe '#unsubscribes' do
      let(:list_id) { '8330ABCd4b' }

      it do
        VCR.use_cassette('unsubscribes') do
          expect(subject.unsubscribes(list_id: list_id)).to eql([{ email: 'john.doe@example.org' }])
        end
      end
    end
  end
end
