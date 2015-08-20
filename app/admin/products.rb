ActiveAdmin.register Product do
  index do
    column :id
    column :title
    column :body
    column :price
    column :reviews do |product|
      link_to "reviews", admin_product_reviews_path(product)
    end

    column :images do |product|
      link_to "images", admin_product_images_path(product)
    end

    default_actions
  end
end
