# https://github.com/amro/gibbon

module MailOptOut
  class Services
    class Mailchimp
      include MailOptOut::Service

      def initialize(options = {})
        @request = ::Gibbon::Request.new(api_key: options[:api_key] || ENV['MAILCHIMP_API_KEY'])
      end

      def lists
        response = request.lists.retrieve(params: { 'fields': 'lists.id,lists.name' }).body['lists']
        response.map do |record|
          {
            id:  record['id'],
            name: record['name'],
          }
        end
      end

      def unsubscribes(list_id:)
        params = { status: 'unsubscribed', fields: 'members.email_address,members.status' }
        response = request.lists(list_id).members.retrieve(params: params).body['members']
        response.map do |record|
          {
            email: record['email_address']
          }
        end
      end

      def self.discoverable?
        !!(defined?(::Gibbon) && ENV['MAILCHIMP_API_KEY'])
      end

      private

      attr_reader :request, :list_id
    end
  end
end
