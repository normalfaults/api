# == Schema Information
#
# Table name: settings
#
#  id   :integer          not null, primary key
#  name :string(255)
#  hid  :string(255)
#  foo  :string(255)
#
# Indexes
#
#  index_settings_on_foo  (foo)
#  index_settings_on_hid  (hid) UNIQUE
#

describe Setting do
  context 'persistence' do
    before :each do
    end
  end
end
