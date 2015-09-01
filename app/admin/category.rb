ActiveAdmin.register Category, { :sort_order => :name_asc }    do
  filter :items

  index do
    column :name
    actions
  end
end
