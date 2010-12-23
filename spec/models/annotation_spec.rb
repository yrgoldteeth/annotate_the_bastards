require 'spec_helper'

describe Annotation do
  it {should belong_to(:book)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:body)}
  it {should validate_presence_of(:original_url)}
  it {should validate_presence_of(:page_number)}
  it {should validate_presence_of(:line_number)}

  context 'scopes' do
    before{ 5.times{Annotation.make} }

    describe '.start_page' do
      it 'returns results equal to or greater than the page number received' do
        Annotation.start_page(5).minimum("page_number").should >= 5
      end
    end
    
    describe '.result_set' do
      it 'returns page_number, line_number, body, title and original url in collection' do
        Annotation.result_set.map(&:attributes).map(&:keys).uniq.flatten.sort.should == %w(original_url title page_number line_number body).sort
      end
    end

    describe '.after' do
      before do
        Annotation.delete_all
        @first  = Annotation.make(:page_number => 5, :line_number => 5)
        @second = Annotation.make(:page_number => 5, :line_number => 23)
        3.times { Annotation.make(:page_number => rand(10) + 6) }
      end

      it 'returns results from later than the page' do
        Annotation.after(@first).count.should == 4
      end

      it 'returns results from later on the same page' do
        Annotation.after(@first).include?(@second).should be true
      end
    end
  end
  
  let(:annotation) { Annotation.make }
  subject{ annotation }

  describe '#to_s' do
    it 'returns page_number.line_number - title' do
      subject.to_s.should == %Q(#{subject.page_number}.#{subject.line_number} - #{subject.title})
    end
  end
end
