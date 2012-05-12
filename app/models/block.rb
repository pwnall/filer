class Block < ActiveRecord::Base
  # User who can read and write to that block.
  belongs_to :owner, class_name: 'User', inverse_of: :blocks
  
  # First node that the block is allocated to.
  #
  # Used to identify the blocks belonging to a node with more than 1 block.
  belongs_to :node0, class_name: 'Node'
  validates :node0, presence: { unless: lambda { owner.nil? }}
  
  # The block number, for a node with more than one block.
  validates :serial, presence: { unless: lambda { node0.nil? } },
      numericality: { allow_nil: true, greater_than_or_equal_to: 0 },
      uniqueness: { allow_nil: true, scope: [:node0_id] }

  # The storage device backing this block.
  #
  # This should be replaced by a list of devices, for redundant storage.
  belongs_to :device, inverse_of: :blocks
  validates :device, presence: true
end
