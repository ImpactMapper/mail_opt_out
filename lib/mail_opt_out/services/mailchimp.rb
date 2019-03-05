# https://github.com/amro/gibbon

module MailOptOut
  module Services
    class Mailchimp < MailOptOut::Service
      include Base

      def self.discoverable?
        !!(defined?(::Gibbon) && ENV['MAILCHIMP_API_KEY'])
      end

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

        result = create_member(email: email, list_id: list.number)
        case result
        when :created
          return true
        when :invalid, :forgotten
          return false
        when :exists, :not_allowed
          # Do Nothing
        end
        return unless result == :exists

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
          }.with_indifferent_access
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
        :created
      rescue Gibbon::MailChimpError => error
        return :exists if error.title == 'Member Exists'
        # detail="Please provide a valid email address."
        return :invalid if error.title == 'Invalid Resource'
        # detail="xxxx was permanently deleted"
        return :forgotten if error.title == 'Forgotten Email Not Subscribed'
        # detail="The requested method and resource are not compatible.
        return :not_allowed if error.title == 'Method Not Allowed'
        raise
      end

      def get_member(email:, list_id:)
        lower_case_md5_hashed_email_address = Digest::MD5.hexdigest(email)
        response = request.lists(list_id).members(lower_case_md5_hashed_email_address).retrieve.body
        {
          id: response['id'],
          email: response['email_address'],
          status: response['status']
        }.with_indifferent_access
      rescue Gibbon::MailChimpError => error
        return if error.title == 'Resource Not Found'
        raise
      end

      attr_reader :request, :list_id
    end
  end
end
