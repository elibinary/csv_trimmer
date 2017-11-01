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

      send(@options[:act])
    end

    def cut
      rows = CSV.read(@source_file)
      i = 0
      j = cut_num
      max_length = rows.length
      while i < max_length
        j = j > max_length ? max_length : j
        CSV.open("#{file_name}-#{i + 1}-#{j + 1}.csv", 'wb') do |csv|
          rows[i..j].each do |row|
            csv << row
          end
        end

        i += cut_num
        j += cut_num
      end
    end

    def cut_by
      unless File.file?(@source_file)
        puts 'file not found'
        return
      end

      unless @options[:cut_by]
        puts 'cut by what'
        return
      end
      # column = ''
      by_cul = @options[:cut_by].to_i
      # header = []
      CSV.foreach(@source_file) do |row|
        CSV.open("#{file_name}-value-#{row[by_cul]}.csv", 'ab') do |csv|
          csv << row
        end
      end
    end

    def file_name
      @file_name ||= File.basename(@source_file)
    end

    def cut_num
      @cut_num ||= @options[:cut].to_i
    end
  end
end