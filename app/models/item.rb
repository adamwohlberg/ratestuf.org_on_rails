class Item < ActiveRecord::Base
  ## Associations ##
  has_and_belongs_to_many :categories, join_table: :categories_items
  has_many :ratings

  ## Scopes ##
  scope :search_terms_ratings, -> (params){ joins(:ratings, :categories).where("items.name REGEXP '#{params}' OR categories.name REGEXP '#{params}'") }

  ## Class Methods ##
  def self.filter_search_query(search_term, result = [])
    # order of terms with periods should be listed prior to the same term with no period to avoid duplicate results e.g. ['uber','. uber']
    terms_that_mean_versus = [' versus ', ' versus', ' versus', 'versus', ' vs.', 'vs.', ' vs', ' vs ']
    search_term = search_term.strip
    terms_that_mean_versus.each do |versus|
      if search_term.include?(versus)
        words = search_term.split(versus)
        words.each do |word|
          result << (word.strip)
        end
        break
      end
    end
    result.present? ? result.flatten.uniq : [search_term]
  end

  def self.search(search_term, result = [])
    params = filter_search_query(search_term).join('|')
    items = Item.search_terms_ratings(params).ids
    Rating.generate_format(Rating.item_ratings(items))
  end
end
