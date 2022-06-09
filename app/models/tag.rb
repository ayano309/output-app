class Tag < ApplicationRecord
  has_many :article_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :articles, through: :article_tags

  validates :name, uniqueness: true, presence: true

  def self.search_articles_for(content, method)
    
    if method == 'perfect'
      tags = Tag.where(name: content)
    end
    # injectはたたみ込み演算
    return tags.inject(init = []) {|result, tag| result + tag.articles}
    
  end
end
