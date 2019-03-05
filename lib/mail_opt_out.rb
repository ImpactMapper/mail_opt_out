require 'mail_opt_out/engine'

require 'mail_opt_out/service'
require 'mail_opt_out/services/mailchimp'

module MailOptOut
  mattr_accessor :services
  self.services = []

  def self.sync
    services.each(&:sync)
  end

  def self.discover_services
    Dir['./mail_opt_out/services/*.rb'].each do |service|
      services << service.new if service.discoverable?
    end
  end
end
