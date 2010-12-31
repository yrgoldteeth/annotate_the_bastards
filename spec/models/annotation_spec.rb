require 'spec_helper'

describe Annotation do
  it {should belong_to(:book)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:body)}
  it {should validate_presence_of(:original_url)}
  it {should validate_presence_of(:page_number)}
  it {should validate_presence_of(:line_number)}

  context 'scopes' do
    before do
      @first  = Annotation.make(:page_number => 5,  :line_number => 5)
      @second = Annotation.make(:page_number => 5,  :line_number => 23)
      @third  = Annotation.make(:page_number => 6,  :line_number => 2)
      @fourth = Annotation.make(:page_number => 6,  :line_number => 9)
      @fifth  = Annotation.make(:page_number => 28, :line_number => 22)
    end

    describe '.start_page' do
      it 'returns results equal to or greater than the page number received' do
        Annotation.start_page(5).minimum("page_number").should >= 5
      end
    end

    describe '.before' do
      it 'returns results from earlier than the page' do
        Annotation.before(@third).count.should == 2
      end
      
      it 'returns results from earlier on the same page' do
        Annotation.before(@fourth).include?(@third).should be true
      end
    end
    
    describe '.after' do
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
    it 'returns page_number.line_number' do
      subject.to_s.should == %Q(#{subject.page_number}.#{subject.line_number})
    end
  end
end
