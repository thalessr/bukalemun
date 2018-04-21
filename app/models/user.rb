# frozen_string_literal: true

class User < ApplicationRecord

  module UserRoles
    DOCTOR = 'doctor'
    PATIENT = 'patient'
    ALL = constants(false).collect { |const| const_get(const) }
  end

  FIELDS = %i[last_ip first_name last_name third_party_token browser last_login].freeze

  has_secure_password
  has_one :public_key, dependent: :restrict_with_error
  has_one :encrypted_private_key, dependent: :restrict_with_error

  enum role: { doctor: 'doctor', patient: 'patient' }

  validates :username, :password_digest, presence: true
  validates :auth_token, uniqueness: true
  validates :role, inclusion: { in: User::UserRoles::ALL }

  store_accessor :data, *FIELDS

  def sign_in(request)
    generate_authentication_token
    self.last_ip = request.remote_ip
    self.last_login = Time.zone.now
    save!
  end

  def generate_authentication_token
    loop do
      self.auth_token = User.friendly_token
      break unless self.class.exists?(auth_token: auth_token)
    end
  end

  def sign_out
    update_attributes(auth_token: nil)
  end

  def to_param
    username
  end

  class << self

    def friendly_token(length = 20)
      rlength = (length * 3) / 4
      SecureRandom.urlsafe_base64(rlength).tr('lIO0', 'sxyz')
    end

  end

end
