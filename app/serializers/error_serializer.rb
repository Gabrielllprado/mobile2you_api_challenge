module ErrorSerializer
    def self.serialize(titles)
        return if titles.nil?
        json = {}
        new_hash = []
        titles.each do |title|
            next if title.errors.empty?
            new_hash.push(title.errors.to_hash.map do |k, v|
                v.map do |msg|
                {id: title.show_id, column: k, title: msg}
                end
            end.flatten)
        end

      json[:errors] = new_hash
      json
    end
end