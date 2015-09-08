class Item < ActiveRecord::Base
  has_many :categories_items
  has_many :categories, through: :categories_items
  has_many :ratings

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
    params = filter_search_query(search_term)
    params.each do |query|
      result << Item.find_by_sql([
        "SELECT (AVG(x_rating)*100) AS xRating, (AVG(y_rating)*100) AS yRating, 
        COUNT(x_rating) AS votes, items.name, items.id, items.url FROM items 
        JOIN categories_items ON items.id = categories_items.item_id 
        JOIN categories ON categories.id = categories_items.category_id 
        JOIN ratings ON ratings.item_id = items.id 
        WHERE items.name LIKE concat('%', ?, '%') OR categories.name LIKE concat('%', ?, '%') 
        GROUP BY items.name 
        LIMIT 10", query, query
        ])
    end
    terms = result.flatten
    terms
  end
end
