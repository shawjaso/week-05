# 
# Here is where you will write the class Quotes
# 
# For more information about classes I encourage you to review the following:
# 
# @see http://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Classes
# @see Programming Ruby, Chapter 3
# 
# 
# For this exercise see if you can employ the following techniques:
# 
# Use class convenience methods: attr_reader; attr_writer; and attr_accessor.
# 
# Try using alias_method to reduce redundancy.
# 
# @see http://rubydoc.info/stdlib/core/1.9.2/Module#alias_method-instance_method
# 
class Quotes
  @file = nil
  @lines = nil
  @@missing_quote_msg = "Could not find a quote at this time" 
  
  # Constructor
  def initialize(params = {})
    if params.has_key?(:file)
      read_file params[:file]
    end
  end
  
  # Sets the file name
  def file
    return @file
  end

  # Returns all lines
  def all
    @lines
  end

  # Returns all quotes
  def quotes
    all
  end

  # Returns the n-th item from the file
  def [](fixnum)
    find(fixnum)
  end

  # Sets the missing quote message
  def self.missing_quote=(value)
    @@missing_quote_msg = value
  end

  # Returns the element with the given index
  def find(index)
    if @file != nil
      if index < @lines.length
        @lines[index]
      else
        []
      end
    else
      @@missing_quote_msg
    end
  end

  def search(params={})
    if @file != nil
      if params.length == 0
        all
      else
        results = []
        if params.has_key?(:include)
          @lines.each do |line|
            if line.include?params[:include]
              results.push line
            end
          end
        end
        if params.has_key?(:start_with)
          @lines.each do |line|
            if line.start_with?params[:start_with]
              results.push line
            end
          end
        end
        if params.has_key?(:end_with)
          @lines.each do |line|
            if line.end_with?params[:end_with]
              results.push line
            end
          end
        end
        results
      end
    else
      []
    end
  end

  def self.load(file_name)
    newQuote = Quotes.new({:file => file_name})
    return newQuote
  end

  private

  # Reads in file
  def read_file(file_name)
    @lines = []
    if File.exist?file_name
      @file = file_name
      File.open(@file) do |file|
        while line = file.gets
          @lines.push line.strip
        end
      end
    end
  end

end
