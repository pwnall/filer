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
    rescue SystemCallError
      self.dev_path = nil
    end
    super
  end
end
