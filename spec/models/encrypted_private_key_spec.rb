require 'rails_helper'

RSpec.describe EncryptedPrivateKey, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'db indexes' do
    it { is_expected.to have_db_index(:user_id) }
  end
end
