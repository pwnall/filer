# Ensures that an attribute is an existing path on the server file-system.
class PathPresenceValidator < ActiveModel::EachValidator
  def check_validity!
    if options[:access] && ![:read, :write].include?(option[:access])
      raise ArgumentError, 'Invalid :access option value'
    end
    if options[:type] && ![:file, :directory].include?(option[:type])
      raise ArgumentError, 'Invalid :type option value'
    end
    super
  end

  def validate_each(record, attribute, value)
    unless File.exist? value
      record.errors.add attribute, ' does not exist'
      return
    end
    
    case options[:access]
    when :read
      unless File.readable? value
        record.errors.add attribute, ' is not readable'
      end
    when :write
      unless File.writable? value
        record.errors.add attribute, ' is not writable'
      end
    end

    case options[:type]
    when :file
      unless File.file? value
        record.errors.add attribute, ' is not a file'
      end
    when :directory
      unless File.directory? value
        record.errors.add attribute, ' is not a directory'
      end
    end
  end
end
