require "csv_trimmer/version"
require 'csv_trimmer/trimmer'

module CsvTrimmer
  def self.trimmer(options)
    source_file = options[:source_file]
    Trimmer.new(source_file, options).run
  end
end
