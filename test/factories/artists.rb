# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :artist do |f|
  f.name "MyString"
  f.nationality "MyString"
  f.gender false
  f.birth "2011-04-16 20:03:07"
end