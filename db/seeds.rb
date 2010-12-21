# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#

books = [
          {:title => %(The Recognitions),    :original_url => %(http://williamgaddis.org/recognitions/index.shtml)},
          {:title => %(JR),                  :original_url => %(http://williamgaddis.org/jr/index.shtml)},
          {:title => %(Carpenters Gothic),   :original_url => %(http://williamgaddis.org/gothic/index.shtml)},
          {:title => %(A Frolic Of His Own), :original_url => %(http://williamgaddis.org/frolic/index.shtml)},
          {:title => %(Agape Agape),         :original_url => %(http://williamgaddis.org/agape/index.shtml)}
        ]

books.each{|b| Book.create!(b)}
