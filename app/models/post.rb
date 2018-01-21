class Post < ApplicationRecord
  has_many :comments

  def self.censor
    Post.all.each { | post |
      if post.id % 5 == 0 || post.id == 1
        post.update_attributes(:title => 'SPAM')
      end
    }
  end

end
