# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  session_token   :string           not null
#
class User < ApplicationRecord

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}, allow_nil: true
    before_validation :ensure_session_token

    attr_reader :password

    def self.find_by_credentials(username, password)
        user = self.find_by(username: params[:username])
        if user && user.is_password?(password)
            user
        else
            nil 
        end
    end

    def is_password?(other_pass)
        pass_object = BCrypt::Password.new(self.password_digest)
        pass_object.is_password?(other_pass)
    end

    # def self.generate_session_token
    #     SecureRandom.urlsafe_base64
    # end

    def password=(new_password)
        self.password_digest = BCrypt::Password.create(new_password)
        @password = new_password
    end

    def ensure_session_token
        self.session_token ||= SecureRandom.urlsafe_base64
    end

end
