# Storage device backing the contents of some blocks.
class Device < ActiveRecord::Base
  # Points to the directory that stores this device's blocks.
  validates :path, path_presence: { access: :write, type: :directory },
      presence: true, length: 1..128
  attr_accessible :path
  
  # The root of the file-system storing this device's blocks. 
  validates :dev_path, length: 1..64, presence: true
  
  # dev_path is automatically recomputed when path changes.
  def path=(new_path)
    begin
      self.dev_path = Sys::Filesystem.mount_point new_path
      @dev_stat = nil
    rescue SystemCallError
      self.dev_path = nil
    end
    super
  end
  
  # Creates a block on the device.
  # @return [Block] newly created Block instance
  def create_block
    # TODO(pwnall): code
  end

  # Amount of free space on the device.
  # @return [Integer] number of blocks that can be allocated on the device 
  def free_block_count
    dev_stat ? dev_stat.blocks_free / (Block.size / dev_stat.block_size) : 0
  end
  
  # Paths to be suggested for new devices.
  def self.dev_paths
    begin
      Sys::Filesystem.mounts.map { |mount| mount.mount_point }.uniq
    rescue SystemCallError
      []
    end
  end
  
  # Used internally by other instance methods.
  # @return [Sys::Filesystem::Stat] a Stat instance for this device, or nil if
  #     the device path is invalid
  def dev_stat
    begin
      @dev_stat ||= Sys::Filesystem.stat dev_path
    rescue SystemCallError
      @dev_stat = nil
    end
  end
end
