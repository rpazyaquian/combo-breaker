# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.all.each do |category|
  category.destroy
end

categories = ["Afghan", :afghani],
["African", :african],
["American (New)", :newamerican],
["American (Traditional)", :tradamerican],
["Arabian", :arabian],
["Argentine", :argentine],
["Armenian", :armenian],
["Barbeque", :bbq],
["Brazilian", :brazilian],
["Burgers", :burgers],
["Cajun/Creole", :cajun],
["Cambodian", :cambodian],
["Cheesesteaks", :cheesesteaks],
["Chinese", :chinese],
["Cuban", :cuban],
["Ethiopian", :ethiopian],
["Filipino", :filipino],
["Greek", :greek],
["Indian", :indpak],
["Italian", :italian],
["Japanese", :japanese],
["Korean", :korean],
["Mediterranean", :mediterranean],
["Mexican", :mexican],
["Middle Eastern", :mideastern],
["Mongolian", :mongolian],
["Moroccan", :moroccan],
["Pakistani", :pakistani],
["Persian/Iranian", :persian],
["Peruvian", :peruvian],
["Pizza", :pizza],
["Portuguese", :portuguese],
["Seafood", :seafood],
["Soul Food", :soulfood],
["Southern", :southern],
["Spanish", :spanish],
["Sushi", :sushi],
["Taiwanese", :taiwanese],
["Thai", :thai],
["Turkish", :turkish],
["Vietnamese", :vietnamese]

categories.each do |category|
  Category.create(display_name: category[0], search_value: category[1])
end