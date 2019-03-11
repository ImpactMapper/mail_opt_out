module MailOptOut
  Fabricator(:list, from: MailOptOut::List) do
    number      { "#{rand(1000)}" }
    name        { "List #{FFaker::Animal.common_name}" }
    description { FFaker::Lorem.paragraph }
    published false
  end
end
