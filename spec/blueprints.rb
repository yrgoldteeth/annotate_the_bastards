require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  title        { Faker::Lorem.sentence }
  body         { Faker::Lorem.paragraph }
  slug         { Faker::Lorem.words(1) }
  page_number  { rand(1000) + 3 }
  line_number  { rand(50) + 1 }
  original_url { Faker::Internet.domain_name }
  amazon_url   { Faker::Internet.domain_name }
end

Book.blueprint do
  title
  slug
  original_url
  amazon_url
end

Annotation.blueprint do
  title
  body
  page_number
  line_number
  original_url
  book { Book.make }
end
