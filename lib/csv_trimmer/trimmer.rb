require 'csv'

module CsvTrimmer
  class Trimmer
    def initialize(file, options)
      @source_file = file
      @options = options
    end

    def run
      unless File.file?(@source_file)
        puts 'file not found'
        return
      end

      if @options[:cut] && @options[:cut] > 0
        cut
      end
    end

    def cut
      rows = CSV.read(@source_file)
      i = 0
      j = @options[:cut]
      max_length = rows.length
      while i < max_length
        j = j > max_length ? max_length : j
        CSV.open("#{file_name}-#{i + 1}-#{j + 1}.csv", 'wb') do |csv|
          rows[i..j].each do |row|
            csv << row
          end
        end

        i += @options[:cut]
        j += @options[:cut]
      end
    end

    def file_name
      @file_name ||= File.basename(@source_file)
    end
  end
end