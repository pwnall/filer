# Lists nodes and assigns names to them, like a directory in a file system.
class List < Node
  # The elements of this list.
  has_many :entries, class_name: 'ListEntry'

  # Creates an empty list, and allocates the space for it.
  def self.empty(owner)
    list = List.new
    list.owner = owner
    list.size = 0
    list.save!

    list.grab_space Block.size
  end
end
