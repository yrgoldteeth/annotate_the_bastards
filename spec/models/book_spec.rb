require 'spec_helper'

describe Book do
  it {should have_many(:annotations)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:slug)}
  it {should validate_presence_of(:original_url)}
  it {should validate_presence_of(:amazon_url)}

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

  before{ %w(foo bar baz).each{|s|Book.make(:slug => s)}}

  describe '.slug_list' do
    specify { Book.slug_list.should == %w(foo bar baz).join(', ')}
  end
end
