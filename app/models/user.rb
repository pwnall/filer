# An user account.
class User < ActiveRecord::Base
  include Authpwn::UserModel

  # Virtual email attribute, with validation.
  include Authpwn::UserExtensions::EmailField
  # Virtual password attribute, with confirmation validation.
  include Authpwn::UserExtensions::PasswordField
  # Convenience Facebook accessors.
  # include Authpwn::UserExtensions::FacebookFields


  # Add your extensions to the User class here.
  
  # Admins can mess with the server.
  validates :admin, inclusion: { in: [true, false] }
  
  # The blocks assigned to a user's nodes.
  has_many :blocks, inverse_of: :owner, foreign_key: 'owner_id',
                    dependent: :nullify

  # The nodes (blobs and lists) owned by a user.
  has_many :nodes, inverse_of: :user, dependent: :destroy
end
