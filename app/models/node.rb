# A blob or list.
class Node < ActiveRecord::Base
  # The first block of the file.
  belongs_to :block0, class_name: 'Block'
  validates :block0, presence: true, unless: lambda { size.zero? }

  # Number of bytes stored by this node.
  validates :size, numericality: { greater_than_or_equal_to: 0 }

  # The user that can read and write to this node.
  belongs_to :owner, class_name: 'User', inverse_of: :nodes
  validates :owner, presence: true
  
  # Block list for blocks with multiple nodes.
  has_many :blocks, foreign_key: 'node0_id', inverse_of: :node0, order: :serial

  # Allocates blocks to hold the node's contents.
  def charge_blocks_for_size(node_size)
    block_count = (node_size + Block.size + 1) / Block.size
    blocks = Block.find_free block_count, owner
    blocks.each.with_index do |block, index|
      block.node = node
      block.serial = index
      block.save!
    end

    self.block0 = blocks.first
    self.size = nide_size
    save!

    self
  end
end
