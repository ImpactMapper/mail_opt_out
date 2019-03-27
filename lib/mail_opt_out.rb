require 'mail_opt_out/engine'

require 'mail_opt_out/service'
require 'mail_opt_out/services/base'
require 'mail_opt_out/services/mailchimp'

module MailOptOut
  mattr_accessor :services, :user_class, :async

  self.services = []
  self.user_class ||= 'User'

  def self.sync
    services.each(&:sync)
  end

  def self.discover_services
    Service.subclasses.each do |service|
      services << service.new if service.discoverable?
    end
  end

  def self.opt_out(email:, list_name:)
    services.each do |service|
      launch_service(service_name: service.class.name, method_name: :opt_out, email: email, list_name: list_name)
    end
  end

  def self.opt_in(email:, list_name:)
    services.each do |service|
      launch_service(service_name: service.class.name, method_name: :opt_in, email: email, list_name: list_name)
    end
  end

  private

  def self.launch_service(service_name:, method_name:, email:, list_name:)
    launch_method = :perform_now
    launch_method = :perform_later if self.async

    ServiceJob.method(launch_method).call(
      service_name.to_s,
      method_name.to_s,
      {
        'email'     => email,
        'list_name' => list_name
      }
    )
  end
end
