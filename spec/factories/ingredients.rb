# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ingredient do
    nombre "MyString"
    precio 1
    unidad "MyString"
  end
end
