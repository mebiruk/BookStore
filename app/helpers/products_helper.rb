module ProductsHelper
  def parent_cate id
    category = Category.find_by id: id
    return unless category.parent_id
    Category.find_by id: category.parent_id
  end

  def build_review
    @review = current_user.reviews.build
  end

  def average_star
    num = @reviews.size
    return unless num.positive?
    total = 0
    @reviews.each do |review|
      total += review.rate
    end
    (total / num).round(Settings.round_helper)
  end
end
