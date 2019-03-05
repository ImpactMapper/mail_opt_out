module MailOptOut
  module Service
    def sync
      lists.each do |list|
        number, name = list.values

        list = List.where({ number: number }).take
        list.update(name: name) if list

        list ||= List.where({ name: name }).take
        list.update(number: number) if list

        list ||= List.create({ number: number, name: name })
        list
      end
    end
  end
end
