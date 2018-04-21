# frozen_string_literal: true

class EncryptedPrivateKey < ApplicationRecord

  belongs_to :user

  validates :key, presence: true

end
