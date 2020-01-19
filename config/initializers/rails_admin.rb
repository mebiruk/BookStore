RailsAdmin.config do |config|

  config.model "Category" do
    list do
      fields :id, :name
    end

    create do
      fields :name, :picture, :parent
    end

    edit do
      fields :name, :picture, :parent
    end
  end

  config.model "User" do
    list do
      fields :id, :name, :email, :role
    end

    create do
      fields :name, :role, :email, :password, :password_confirmation
    end

    edit do
      fields :name, :role, :email, :password, :password_confirmation
    end
  end

  config.model "Order" do
    list do
      fields :id, :user, :deliver_status, :receiver, :total_price
    end

    create do
      exclude_fields :order_products
    end

    edit do
      exclude_fields :order_products
    end
  end

  config.model "Product" do
    list do
      fields :id, :category, :title, :price, :num_exist
    end

    create do
      exclude_fields :reviews, :order_products
      field :description, :ck_editor
    end

    edit do
      exclude_fields :reviews, :order_products
      field :description, :ck_editor
    end
  end

  config.model "Review" do
    list do
      exclude_fields :created_at, :updated_at
    end
  end

  config.authenticate_with do
    warden.authenticate! scope: :user
  end

  config.authorize_with :cancancan

  config.parent_controller = "ApplicationController"
  
  config.current_user_method(&:current_user)

  config.show_gravatar = false

  config.actions do
    dashboard

    index do
      except OrderProduct
    end

    new
    bulk_delete
    show
    edit

    delete do
      except Order
    end
  end
end
