class AnnotationParser
  attr_reader :file_lines, :book
  attr_accessor :annotation, :annotation_text

  def initialize annotation_file, book
    raise 'you must send a file' unless File.exist?(annotation_file)
    
    @book       = book
    @file_lines = File.open(annotation_file).readlines
  end

  def inspect
    %{#{self.class}}
  end

  def parse!
    file_lines.each do |line|
      if line =~ annotation_begin_regex
        if @annotation
          @annotation.body = @annotation_text
          putc '.'
          @annotation.save!
        end
        @annotation_text = ''
        @annotation      = Annotation.new(:book => @book, 
                                          :page_number => get_page_number(line),
                                          :line_number => get_line_number(line))
        @annotation_text << line.gsub(annotation_begin_regex, '').strip.chomp.squeeze(' ')
      else
        @annotation_text << '' + line.strip.chomp.squeeze(' ')
      end
    end
  end

  private
  def annotation_begin_regex
    /^[0-9]*\.[0-9]*(\]|\:)/
  end

  def get_page_number line
    line.split('.').first.to_i
  end

  def get_line_number line
    line.split('.').last.gsub(/\D/,'').to_i
  end
end
