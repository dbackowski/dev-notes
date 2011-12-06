require 'digest/md5'
  
class User < ActiveRecord::Base
  validates :login, :presence => true
  validates :passwd, :presence => true, :confirmation => true, :on => :create
  validates :passwd_confirmation, :presence => true, :on => :create
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true

  def full_name
    "#{first_name} #{last_name}"
  end

  def get_gravatar_path
    email_md5 = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{email_md5}?size=64"
  end
end
