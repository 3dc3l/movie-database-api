FactoryBot.define do
	factory :cast do 
		first_name { "xency" }
		suffix { "d" }
		middle_name { "calzo" } 
		last_name { "estadola" }
		stage_name { "naruto" }
		image { fixture_file_upload(Rails.root.join('spec', 'support', 'test_image.png'), 'image/png') }
	end
end