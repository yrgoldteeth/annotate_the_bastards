class JrParser
  ANNOTATION_REGEX = /^[0-9]*\.[0-9]*(\]|\:)/
  attr_reader :file, :book, :parsed_results, :save_models, :generated_annotations

  def initialize note_file, save_models=false
    @save_models      = save_models
    @book             = Book.find_by_slug('jr')
    @file             = note_file
    @parsed_results   = []
    @generated_annotations = []
  end

  def run!
    parse
    generate_models
  end

  def parse
    doc = Nokogiri::HTML(open(file))
    n_results = doc.search('//p')
    n_results.each{|p| parsed_results << p_cleaner(p)}
  end

  def generate_models
    parsed_results.each do |result|
      next if result.blank?
      generated_annotations << generate_model(result) if looks_like_annotation?(result)
    end
  end

  private
  # remove new lines, squeeze out ridiculous spaces, sub \u009* codes to normal punctuation
  def p_cleaner p
    p.content.gsub(/\n/,' ').squeeze(' ').strip.gsub(/\u0092/,"'").gsub(/\u0093|\u0094/,'"').gsub(/\u0097/,'--')
  end

  def looks_like_annotation? result
    result =~ ANNOTATION_REGEX ? true : false
  end

  def generate_model r
    page_and_line = r[ANNOTATION_REGEX].split('.')
    result = r.gsub(ANNOTATION_REGEX,'').lstrip
    title  = result.split(':').first.strip
    
    options = {
                :page_number  => page_and_line.first.to_i,
                :line_number  => page_and_line.last.gsub(/\D/,'').to_i,
                :book         => book,
                :title        => title,
                :body         => result.gsub("#{title}" + ':','').strip,
                :original_url => AnnotateTheBastards::SOURCE_URL + "/#{book.slug}/#{File.basename(file)}"
              }
    
    annotation = Annotation.new(options)
    annotation.save! if save_models
    annotation
  end
  
end

