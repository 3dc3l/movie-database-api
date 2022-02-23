FactoryBot.define do
  factory :user do
    email {"sample_user@gmail.com"}
    password {"qwertyuiop"}
    password_confirmation {"qwertyuiop"}
  end
end