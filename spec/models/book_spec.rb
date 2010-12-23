require 'spec_helper'

describe Book do
  it {should have_many(:annotations)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:slug)}
  it {should validate_presence_of(:original_url)}

  context 'scopes' do 
    describe '.result_set' do
      before { 5.times{Book.make} }
      it 'returns title and original url in collection' do
        Book.result_set.map(&:attributes).map(&:keys).uniq.flatten.sort.should == %w(original_url title slug).sort
      end
    end
  end
  
  let(:book) { Book.make }
  subject{ book }
  
  describe '#to_param' do
    it 'returns the slug' do
      subject.to_param.should == subject.slug
    end
  end

  describe '#to_s' do
    it 'returns the title' do
      subject.to_s.should == subject.title
    end
  end
  
end
