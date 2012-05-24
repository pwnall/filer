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

  # Finds unused blocks.
  #
  # This method is intended to allocate blocks for usage in a node. It might do
  # optimizations, such as finding a continuous set of blocks, or ensuring that
  # all the returned blocks are on the same device.
  #
  # @param [User] owner the user that will become the owner of the blocks;
  #                     required because blocks are marked as used by setting
  #                     their owner
  # @param [Integer] count the desired number of blocks
  def self.find_free(owner, count)
    # Best-fit allocation.
    Device.all.sort_by { |d| d.blocks.free.count }.each do |device|
      next unless device.blocks.free.count >= count
      blocks = []
      begin
        1.upto count do |i|
          Device.transaction do
            block = Device.blocks.free.first
            block.owner = owner
            block.save!
          end
        end
        return blocks if blocks.length == count
      rescue
        # The blocks will be de-allocated below.
      end
      blocks.each do |block|
        block.owner = nil
        block.save!
      end
    end
    
    nil
  end
end
