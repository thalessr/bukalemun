require 'rails_helper'

RSpec.describe Content, type: :model do
  describe 'association' do
    it{is_expected.to belong_to(:owner)}
    it{is_expected.to belong_to(:recipient)}

  end
end
