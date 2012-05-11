# A blob or list.
class Node < ActiveRecord::Base
  # The first block of the file.
  belongs_to :block0, class: 'Block'
  validates :block0, presence: true

  # The amount of data stored by this node.
  validates :size, numericality: { :greater_than_or_equal_to => 0 }

  # The user that can read and write to this node.
  belongs_to :owner, class: 'User', inverse_of: :nodes
  validates :owner, presence: true
end
