require 'rails_helper'

RSpec.describe MailOptOut do
  it do
    expect(described_class).to respond_to(:sync)
  end
end
