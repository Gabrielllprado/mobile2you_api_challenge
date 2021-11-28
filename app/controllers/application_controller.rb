class ApplicationController < ActionController::API

    def filtered_result(model, filter)
        table = model.arel_table
        filter = permitted_params(filter)

        #passa por cada filtro para montar as querys e executá-las
        filter&.each do |key, value|
          value.each do |operator, operator_value|

            query ||= operator_value(table, key.to_sym, operator, operator_value)

            next model = model.where.not(query) if %w[nin not_in].include?(operator)

            model = model.where(query)
          end
        end
        model
    end

    #tratamento para os operadores passados nos filtros
    def operator_value(table, field, operator, value)
        operator = operator.to_s
        return table[field].eq(value) if operator == 'eq'
        return table[field].not_eq(value) if operator == 'neq'
        return table[field].lt(value) if operator == 'lt'
        return table[field].gt(value) if operator == 'gt'
        return table[field].lteq(value) if operator == 'lte'
        return table[field].gteq(value) if operator == 'gte'

        return table[field].matches("%#{value.gsub(/[ ]+/, '%')}%") if %w[ilike like contain].include?(operator)
    end

    #filtra somente os filtros permitidos para a aplicação
    def permitted_params(filter)
        new_filter = {}
        filter&.each do |key, value|
            if key == "release_year" || key == "country" || key == "media_type"
                new_filter[key] = value
            end
        end
        new_filter
    end
end
