Fabricator(:subscription, from: MailOptOut::Subscription) do
  list  { "List #{FFaker::Animal.common_name}" }
end
