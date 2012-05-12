# Storage device backing the contents of some blocks.
class Device < ActiveRecord::Base
  validates :path, :path_presence => { :access => :write }
  attr_accessible :path
end

# Ensures that an attribute is an existing path on the server file-system.
class PathPresenceValidator < ActiveModel::EachValidator
  def check_validity!
    
  end

  def validate_each(record, attribute, value)
    unless File.exist? value
      record.errors.add(attribute, ' does not exist')
    end
  end
end
