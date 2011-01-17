require 'spec_helper'

describe Book do
  it {should have_many(:annotations)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:slug)}
  it {should validate_presence_of(:original_url)}

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
