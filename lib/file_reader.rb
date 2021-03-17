class ReadFile
  attr_reader :file_lines, :file_size, :err_msg, :filepath
  def initialize(filepath)
    @err_msg = ''
    @filepath = filepath
    begin
      @file_lines = File.readlines(@filepath)
      @file_size = @file_lines.size
    rescue StandardError => e
      @file_lines = []
      @err_msg = "The given file path has  an error #{e} "
    end
  end
end
