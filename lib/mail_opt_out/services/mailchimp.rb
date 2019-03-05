# https://github.com/amro/gibbon

module MailOptOut
  class Services
    class Mailchimp
      include MailOptOut::Service

      def initialize(options = {})
        @request = ::Gibbon::Request.new(api_key: options[:api_key] || ENV['MAILCHIMP_API_KEY'])
      end

      def opt_out(email:, list_name:)
        list = List.where({ name: list_name }).take
        return unless list&.number

        member = get_member(email: email, list_id: list.number)
        return unless member

        update_member(list_id: list.number, member_id: member['id'])
      end

      def opt_in(email:, list_name:)
        list = List.where({ name: list_name }).take
        return unless list&.number

        return true if create_member(email: email, list_id: list.number)

        member = get_member(email: email, list_id: list.number)
        return unless member

        update_member(list_id: list.number, member_id: member['id'], status: 'subscribed')
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

      private

      def update_member(list_id:, member_id:, status: 'unsubscribed')
        request.lists(list_id).members(member_id).update(body: { status: status })
        true
      rescue Gibbon::MailChimpError => error
        return false if error.title == 'Resource Not Found'
        raise
      end

      def create_member(email:, list_id:)
        request.lists(list_id).members.create(body: { email_address: email, status: 'subscribed' })
        true
      rescue Gibbon::MailChimpError => error
        return false if error.title == 'Member Exists'
        raise
      end

      def get_member(email:, list_id:)
        lower_case_md5_hashed_email_address = Digest::MD5.hexdigest(email)
        response = request.lists(list_id).members(lower_case_md5_hashed_email_address).retrieve.body
        {
          id: response['id'],
          email: response['email_address'],
          status: response['status']
        }
      rescue Gibbon::MailChimpError => error
        return if error.title == 'Resource Not Found'
        raise
      end

      def self.discoverable?
        !!(defined?(::Gibbon) && ENV['MAILCHIMP_API_KEY'])
      end

      private

      attr_reader :request, :list_id
    end
  end
end
