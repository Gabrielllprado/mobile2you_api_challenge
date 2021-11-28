require 'swagger_helper'

RSpec.describe 'list_titles', type: :request do

  path '/list_titles' do

    get "List Netflix titles" do
      tags "Netflix Titles"
      parameter name: "filter[release_year][eq]", in: :query, type: :string, required: false, example: 2020
      parameter name: "filter[release_year][neq]", in: :query, type: :string, required: false, example: 2020
      parameter name: "filter[release_year][lt]", in: :query, type: :string, required: false, example: 2020
      parameter name: "filter[release_year][gt]", in: :query, type: :string, required: false, example: 2020
      parameter name: "filter[release_year][lte]", in: :query, type: :string, required: false, example: 2020
      parameter name: "filter[release_year][gte]", in: :query, type: :string, required: false, example: 2020

      parameter name: "filter[country][eq]", in: :query, type: :string, required: false, example: "United States"
      parameter name: "filter[country][neq]", in: :query, type: :string, required: false, example: "United States"
      parameter name: "filter[country][contain]", in: :query, type: :string, required: false, example: "United States"
      parameter name: "filter[country][ilike]", in: :query, type: :string, required: false, example: "United States"
      parameter name: "filter[country][like]", in: :query, type: :string, required: false, example: "United States"

      parameter name: "filter[media_type][eq]", in: :query, type: :string, required: false, example: "Movie"
      parameter name: "filter[media_type][neq]", in: :query, type: :string, required: false, example: "Movie"
      parameter name: "filter[media_type][contain]", in: :query, type: :string, required: false, example: "Movie"
      parameter name: "filter[media_type][ilike]", in: :query, type: :string, required: false, example: "Movie"
      parameter name: "filter[media_type][like]", in: :query, type: :string, required: false, example: "Movie"

      response "200", 'successful' do
        let(:"filter[release_year][eq]") {2020}
        let(:"filter[country][contain]") {"United States"}

        before do
          ListTitle.destroy_all
          ListTitle.create!(show_id: "s148", title: "A Babysitter's Guide to Monster Hunting", media_type: "Movie", release_year: 2020, country: "United States", date_added: Time.now, description: "Recruited by a secret society of babysitters, a high schooler battles the Boogeyman and his monsters when they nab the boy she's watching on Halloween.")
        end
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
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

      response '400', "Error empty file" do
        let(:file) {}
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body.to_json)
            }
          }
        end
        run_test!
      end

      response '422', "Error unique record" do
        let(:file) {Rack::Test::UploadedFile.new(Rails.root.join('spec/netflix_titles.csv')) }
        before do
          ListTitle.destroy_all
          ListTitle.create!(show_id: "s148", title: "A Babysitter's Guide to Monster Hunting", media_type: "Movie", release_year: 2020, country: "United States", date_added: Time.now, description: "Recruited by a secret society of babysitters, a high schooler battles the Boogeyman and his monsters when they nab the boy she's watching on Halloween.")
        end
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body.to_json)
            }
          }
        end
        run_test!
      end
    end
  end
end
