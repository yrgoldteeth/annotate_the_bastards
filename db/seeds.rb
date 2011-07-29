books = [
          {:title        => %(The Recognitions),
           :slug         => %(recognitions), 
           :amazon_url   => %(http://www.amazon.com/gp/product/0140187081?ie=UTF8&tag=annthebas-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0140187081),
           :original_url => %(http://williamgaddis.org/recognitions/index.shtml)},
          
          {:title        => %(JR),
           :slug         => %(jr), 
           :amazon_url   => %(http://www.amazon.com/gp/product/1843541653?ie=UTF8&tag=annthebas-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=1843541653),
           :original_url => %(http://williamgaddis.org/jr/index.shtml)},
          
          {:title        => %(Carpenters Gothic),
           :slug         => %(gothic), 
           :amazon_url   => %(http://www.amazon.com/gp/product/0141182229?ie=UTF8&tag=annthebas-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0141182229),
           :original_url => %(http://williamgaddis.org/gothic/index.shtml)},
           
          {:title        => %(A Frolic Of His Own),
           :slug         => %(frolic), 
           :amazon_url   => %(http://www.amazon.com/gp/product/0684800527?ie=UTF8&tag=annthebas-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0684800527),
           :original_url => %(http://williamgaddis.org/frolic/index.shtml)},
          
          {:title        => %(Agape Agape),
           :slug         => %(agape), 
           :amazon_url   => %(http://www.amazon.com/gp/product/0142437638?ie=UTF8&tag=annthebas-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0142437638),
           :original_url => %(http://williamgaddis.org/agape/index.shtml)}
        ]

books[0..1].each{|b| Book.create!(b)}

Book.all.each do |b|
  files = Dir.glob("doc/#{b.slug}/*").sort
  files.each{|f|puts f;p=Parser.new(f,b,true);p.run!}
end
