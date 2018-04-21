# frozen_string_literal: true

class User < ApplicationRecord

  module UserRoles
    DOCTOR = 'doctor'
    PATIENT = 'patient'
    ALL = constants(false).collect { |const| const_get(const) }
  end

  FIELDS = %i[last_ip first_name last_name auth_token third_party_token browser last_login].freeze

  has_secure_password

  enum role: { doctor: 'doctor', patient: 'patient' }

  validates :username, :password_digest, presence: true
  validates :role, inclusion: { in: User::UserRoles::ALL }

  store_accessor :data, *FIELDS

  def sign_in(request)
    self.auth_token = User.friendly_token
    self.last_ip = request.remote_ip
    self.browser = request.user_agent
    self.last_login = Time.zone.now
    save!
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
