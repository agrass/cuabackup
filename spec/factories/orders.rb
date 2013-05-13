# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    patient ""
    esPaciente false
    horario 1
    comentarios "MyString"
  end
end
