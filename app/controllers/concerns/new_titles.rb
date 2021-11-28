module NewTitles
    require 'csv'

    #cria um novo objeto da classe ListTitle para cada registro do CSV
    def create_objects(file)
        titles = []
        csv = CSV.parse(file, :headers => true)
        csv.each do |row|
            hash = row.to_hash.with_indifferent_access
            hash[:media_type] = hash.delete :type #substitui o campo type por media_type
            titles.push(ListTitle.new(hash))
        end
        return titles
    end
end