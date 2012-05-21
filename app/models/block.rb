class Block < ActiveRecord::Base
  # First node that the block is allocated to.
  #
  # Used to identify the blocks belonging to a node with more than 1 block.
  belongs_to :node0, class_name: 'Node'
  validates :node0, presence: { unless: lambda { owner.nil? }}
  
  # The block number, for a node with more than one block.
  validates :serial, presence: { unless: lambda { node0.nil? } },
      numericality: { allow_nil: true, greater_than_or_equal_to: 0 },
      uniqueness: { allow_nil: true, scope: [:node0_id],
                    unless: :nil? }

  # The storage device backing this block.
  #
  # This should be replaced by a list of devices, for redundant storage.
  belongs_to :device, inverse_of: :blocks
  validates :device, presence: true

  # User who can read and write to that block.
  belongs_to :owner, class_name: 'User', inverse_of: :blocks

  # Blocks that can be allocated.
  scope :free, where(owner_id: nil)
  
  # The system's block size.
  # @return [Integer] system block size, guaranteed to be a power of two
  def self.size
    1.megabyte
  end

  # Path to the file storing the block's contents.
  # @return [String] fully expanded path pointing to the block's file
  def file_path
    File.join device.path, id.to_s(16)
  end
end
