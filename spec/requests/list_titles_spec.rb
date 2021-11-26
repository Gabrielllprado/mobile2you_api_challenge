require 'swagger_helper'

RSpec.describe 'list_titles', type: :request do

  path '/list_titles' do

    get "List Netflix titles" do
      tags "Netflix Titles"
      produces 'application/vnd.api+json'
      parameter name: "filter[release_year][eq]", in: :query, type: :integer, required: false, example: 2020
      parameter name: "filter[country][eq]", in: :query, type: :string, required: false, example: "United States"
      parameter name: "filter[media_type][eq]", in: :query, type: :string, required: false, example: "Movie"

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end

      response "200", 'successful' do
        run_test!
      end
    end

    post "Insert data from CSV file" do
      tags "Netflix Titles"
      consumes 'application/vnd.api+json'
      produces 'application/vnd.api+json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {

          file:{ type: :object, properties: {
            path: { type: :string, example: "/path_to_file/netflix_titles.csv" }
            }
          }
        }
      }

      let(:'Content-Type') { 'application/json' }

      response '201', "Titles Saved in database" do
        let(:payload) do
          {
            "file": {
              "path": "/home/gabriel/Downloads/netflix_titles.csv"
            }
          }
        end
        run_test!
      end

      response '422', 'Error' do
        let(:payload) do
          {
            file: {
              path: "/home/gabriel/downloads/netflix_titles.csv"
            }
          }
        end
        run_test!
      end
    end
  end
end
