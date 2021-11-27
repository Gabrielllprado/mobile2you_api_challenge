class ListTitlesController < ApplicationController
    include NewTitles
    def index
        titles = filtered_result(ListTitle, filter_params)
        render json: titles.order(:release_year), status: :ok
    end

    def create
        begin
            file = File.open(title_params.tempfile)
            file_read = file.read
            titles = create_objects(file_read)
            ListTitle.transaction do
                success = titles.map(&:save)
                if success.all?
                    render json: "Titles Saved in database", status: :created
                else
                    render json: ErrorSerializer.serialize(titles),
                                        status: :unprocessable_entity
                end
            end
        rescue SystemCallError => e
            render json: e.inspect, status: :unprocessable_entity
        rescue NoMethodError => e
            render json: "File can't be read: #{e}", status: :unprocessable_entity
        end
    end

    private

    def title_params
        params[:file]
    end

    def filter_params
        params_permitidos = params.permit!
        params_permitidos[:filter]
    end
end