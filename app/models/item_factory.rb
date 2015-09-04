class ItemFactory
  DELIMITERS = [' versus ', ' versus', ' versus', 'versus', ' vs.', 'vs.', ' vs', ' vs ']

  def self.create!(input)
    new(input).create_items
  end

  def initialize(input)
    @input = input
  end

  def create_items
    tokenize.each do |token|
      next if Item.exists?(name: token)
      next if Category.where("name LIKE concat('%', '#{token}', '%')").exists?
        Item.create!(name: token) 
        item_id = Item.where(name: token).first.id
        Rating.create!(item_id: item_id, x_rating: 0.5, y_rating: 0.5)
        CategoriesItem.create!(item_id: item_id, category_id: 1)        
    end
    self
  end

  def tokenize
    result = []
    @stripped_input = @input.strip
    DELIMITERS.each do |versus|
      if @stripped_input.include?(versus)
        words = @stripped_input.split(versus)
        words.each do |word|
          result << (word.strip)
        end
        break
      end
    end
    result.present? ? result.flatten.uniq : [@stripped_input]
  end

  private

  def sanitized_name
    @sanitized_name ||= @input.strip
  end
end
