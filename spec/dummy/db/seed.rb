user = User.create!({ name: 'John Doe', email: 'john.doe@example.org '})
puts("user #{user.name} created!")

list = MailOptOut::List.create!({ published: false, name: 'Mail opt In Newsletters List', number: '42x', description: "I'd like to subscribe to Mail Opt In newsletter"})
puts("list #{list.name} created!")

list = MailOptOut::List.create!({ published: true, name: 'Mail opt In Product Updates List', number: '42x', description: "I'd like to receive emails containing Mail Opt In updates and tips"})
puts("list #{list.name} created!")

subscription = MailOptOut::Subscription.create!({
  user: user,
  list: list
})
puts("subscription of #{user.name} to #{subscription.list.name} subscribed!")
