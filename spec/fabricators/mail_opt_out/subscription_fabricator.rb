module MailOptOut
  Fabricator(:subscription, from: MailOptOut::Subscription) do
    list
  end
end
