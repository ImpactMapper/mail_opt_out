user = User.create!({ name: 'John Doe', email: 'john.doe@example.org '})
puts("#{user.name} created!")
subscription = MailOptOut::MailListSubscription.create!({
  user: user,
  list: 'Notification System'
})
puts("#{subscription.list} subscribed!")