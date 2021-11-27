require 'rails_helper'

RSpec.describe ListTitle, type: :model do
  before(:each) do
    @model = ListTitle.new(show_id: "sw001", title: "Star Wars", media_type: "Movie", release_year: 1977, country: "United States")
  end

  it 'List Title model' do
    title_params = {
      id: 1,
      show_id: "sw002",
      title: "Star Wars: The Empire Strikes Back",
      media_type: "Movie",
      release_year: 1980,
      country: "United States"
    }
    @ListTitle = ListTitle.create!(title_params)
    expect(ListTitle.all.size.positive?).to be true
  end

  it 'validates all attributes' do
    expect(@model).to be_valid
  end

  it 'validates uniqueness' do
    ListTitle.create!(show_id: "sw001", title: "Star Wars", media_type: "Movie", release_year: 1977, country: "United States")
    expect(@model).to be_invalid
  end
end
