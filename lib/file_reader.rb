class ReadFile
    def initialize(filepath)
        @err_msg =''
        @filepath =filepath
        begin
        @file_lines =File.readlines(@filepath)
        @number_of_file_lines =@file_lines.size
        rescue StandardError=> exception
         @file_lines =[]
         @err_msg "The given file path has  an error #{exeption.to_s} "
        end
    end
end