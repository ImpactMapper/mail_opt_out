Fabricator(:mail_list_subscription, from: MailOptOut::MailListSubscription) do
  list  { "List #{FFaker::Animal.common_name}" }
  email { FFaker::Internet.email }
end
