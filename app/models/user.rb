require 'digest/md5'
  
class User < ActiveRecord::Base
  validates :login, :presence => true, :uniqueness => true
  validates :passwd, :presence => true, :confirmation => true, :if => Proc.new{|o| o.new_record? || o.password_change?}
  validates :passwd_confirmation, :presence => true, :if => Proc.new{|o| o.new_record? || o.password_change?}
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  before_save :calculate_md5_password, :if => Proc.new{|o| o.new_record? || o.password_change?}

  protected
  def password_change?
    @password_change
  end

  public
  def full_name
    "#{first_name} #{last_name}"
  end

  def get_gravatar_path
    email_md5 = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{email_md5}?size=64"
  end

  def calculate_md5_password
    self.passwd = Digest::MD5.hexdigest(passwd)
  end

  def change_passwd(attributes)
    self.attributes = attributes
    @password_change = true

    valid? && save
  end
end
