require 'rails_helper'

RSpec.describe Cast, type: :model do
  before :each do
    @image = fixture_file_upload('support/test_image.png', 'image/png')
  end

  it 'has a title' do
    cast = Cast.new(
      first_name: "", 
      suffix: "d", 
      middle_name: "calzo", 
      last_name: 'estadola', 
      stage_name: 'naruto',
      image: @image
    )
    expect(cast).to_not be_valid

    cast.first_name = 'Has a first_name'
    expect(cast).to be_valid
  end
end
