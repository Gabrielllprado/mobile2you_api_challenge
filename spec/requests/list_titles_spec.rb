require 'swagger_helper'

RSpec.describe 'list_titles', type: :request do

  path '/list_titles' do

    get "List Netflix titles" do
      tags "Netflix Titles"
      parameter name: "filter[release_year][eq]", in: :query, type: :integer, required: false, example: 2020
      parameter name: "filter[country][eq]", in: :query, type: :string, required: false, example: "United States"
      parameter name: "filter[media_type][eq]", in: :query, type: :string, required: false, example: "Movie"

      response "200", 'successful' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: [
                {
                  "id": "s148",
                  "title": "A Babysitter's Guide to Monster Hunting",
                  "genre": "Movie",
                  "year": 2020,
                  "country": "United States",
                  "published_at": "2020-10-15T00:00:00.000Z",
                  "description": "Recruited by a secret society of babysitters, a high schooler battles the Boogeyman and his monsters when they nab the boy she's watching on Halloween."
                }
              ]
            }
          }
        end
        run_test!
      end
    end

    post "Insert data from CSV file" do
      tags "Netflix Titles"
      consumes 'multipart/form-data'
      parameter name: 'file',
      description: 'Select the file to send.',
      in: :formData,
        schema: {
          type: :object,
          properties: {
            file: { type: :file },
          },
      }

      response '201', "Titles Saved in database" do
        let(:file) {Rack::Test::UploadedFile.new(Rails.root.join('spec/netflix_titles.csv')) }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: response.body
            }
          }
        end
        run_test!
      end

      response '422', "Error empty file" do
        let(:file) {}
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: response.body
            }
          }
        end
        run_test!
      end
    end
  end
end
