# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    login "MyString"
    passwd "MyString"
    first_name "MyString"
    last_name "MyString"
    admin false
  end
end
