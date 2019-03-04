user = User.create!({ name: 'John Doe', email: 'john.doe@example.org '})
puts("user #{user.name} created!")

list = MailOptOut::List.create!({ name: 'Notification System', number: '42x' })
puts("list #{list.name} created!")

subscription = MailOptOut::Subscription.create!({
  user: user,
  list: list
})
puts("subscription of #{user.name} to #{subscription.list.name} subscribed!")
