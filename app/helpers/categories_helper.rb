module CategoriesHelper
  def parent_category
    Category.parent_category.pluck :name, :id
  end

  def childs_category
    Category.not_parent_category.pluck :name, :id
  end
end
