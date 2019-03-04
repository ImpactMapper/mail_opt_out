module MailOptOut
  Fabricator(:list, from: MailOptOut::List) do
    number { "#{rand(1000)}" }
    name   { "List #{FFaker::Animal.common_name}" }
  end
end
