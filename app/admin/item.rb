ActiveAdmin.register Item, sort_order: :name_asc do
  filter :categories

  index do
    column :name
    column :url
    actions
  end
end
