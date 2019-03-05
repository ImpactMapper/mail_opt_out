require 'mail_opt_out/engine'

require 'mail_opt_out/service'
require 'mail_opt_out/services/base'
require 'mail_opt_out/services/mailchimp'

module MailOptOut
  mattr_accessor :services
  self.services = []

  def self.sync
    services.each(&:sync)
  end

  def self.discover_services
    Service.subclasses.each do |service|
      services << service.new if service.discoverable?
    end
  end

  def self.opt_out(email:, list_name:)
    services.each { |service| service.opt_out(email: email, list_name: list_name) }
  end

  def self.opt_in(email:, list_name:)
    services.each { |service| service.opt_in(email: email, list_name: list_name) }
  end
end
