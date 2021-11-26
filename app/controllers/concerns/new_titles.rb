module NewTitles
    require 'csv'

    def create_objects(file)
        titles = []
        csv = CSV.parse(file, :headers => true)
        csv.each do |row|
            hash = row.to_hash.with_indifferent_access
            hash[:media_type] = hash.delete :type
            titles.push(ListTitle.new(hash))
        end
        return titles
    end
end