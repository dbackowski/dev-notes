# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    category_id 1
    title "MyString"
    description "MyText"
  end
end
