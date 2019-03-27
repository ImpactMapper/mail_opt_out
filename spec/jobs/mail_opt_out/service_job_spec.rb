require 'rails_helper'

module MailOptOut
  RSpec.describe ServiceJob do
    context do
      before do
        expect_any_instance_of(MailOptOut::Services::Mailchimp).to(
          receive(:opt_in)
          .with(
            email: 'john.doe@example.org',
            list_name: 'Newsletter List'
          )
        )
      end

      it 'should call properly the service' do
        described_class.perform_now(
          'MailOptOut::Services::Mailchimp',
          'opt_in',
          {
            'email'     => 'john.doe@example.org',
            'list_name' => 'Newsletter List'
          }
        )
      end
    end

    it 'matches with enqueued job' do
      expect {
        described_class.perform_later(
          'MailOptOut::Services::Whatever',
          'wtf',
          {}
        )
      }.to have_enqueued_job(described_class)
    end
  end
end
