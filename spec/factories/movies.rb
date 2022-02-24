FactoryBot.define do
	factory :movie do 
		title { "sldfjsdlkfj" }
		slug { "naruto" }
		release_year { '2019' }
		thumbnail_url { "dfdfd" }
		image { fixture_file_upload(Rails.root.join('spec', 'support', 'test_image.png'), 'image/png') }


		factory :movie_with_genres do 
			after(:build) { |movie| movie.genres = [create(:genre)] }
		end
	end
end