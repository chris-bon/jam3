class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  attr_accessor :login

  has_one  :profile, dependent: :destroy
  has_many :posts
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :lockable, :timeoutable #, :omniauthable

  paginates_per 20

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                       uniqueness: { case_sensitive: false }, 
                           length: { maximum: 40 }, confirmation: true
  validates :username, uniqueness: { case_sensitive: false }, 
                           length: { minimum: 4, maximum: 40 }, presence: true
  validates_format_of :username, with: /\A[a-zA-Z0-9]*\z/, on: :create, 
    message: 'Only letters and numbers are permitted for your username!'
  validate :username_differs_from_emails
  validate :password_complexity

  def self.paged page_number
    order(admin: :desc, username: :asc).page page_number
  end

  def self.search_and_order search, page_number
    if search
      where('username LIKE ?', "%#{search.downcase}%").order(
        admin: :desc, username: :asc).page page_number
    else
      order(admin: :desc, username: :asc).page page_number
    end
  end

  def self.last_signups count
    order(created_at: :desc).limit(count).select 'id','username','created_at'
  end

  def self.last_signins count
    properties = ['id', 'username', 'last_sign_in_at']
    order(last_sign_in_at: :desc).limit(count).select properties
  end

  def self.users_count
    where('admin = ? AND locked = ?', false, false).count
  end

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where([
        'lower(username) = :value OR lower(email) = :value',
        { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).first
    end
  end

  def username_differs_from_emails
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  def password_complexity
    complexity_regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/
    error_message =
      'password must have a lowercase letter, an uppercase letter, and a digit'
    if password.present? && !password.match(complexity_regex)
      errors.add :password, error_message
    end
  end

  def login= login
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def forem_name
    name
  end

  def forem_email
    email_address
  end
end
