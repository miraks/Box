module ActiveRecord
  module UpdateNumerous
    # Принимает данные в виде
    # { id1 => { field1: value1, field2: value2 }, ... }
    # Например,
    # { 1 => { name: 'Ivan', age: '30' }, ... }
    def update_numerous data
      return unless data.present?

      ids = data.keys
      values = data.values
      fields = values.first.keys
      set_part = fields.map{ |field| "#{field} = values.#{field}" }.join(",\n")
      values_part = data.map{ |id, values| "(#{id}, #{values.values.join(', ')})" }.join(",\n")
      as_part = "values (id, #{fields.join(', ')})"
      where_part = "#{table_name}.id = values.id"

      query = <<-QUERY
      UPDATE #{table_name}
      SET
        #{set_part}
      FROM (
        VALUES
          #{values_part}
      ) AS #{as_part}
      WHERE #{where_part}
      QUERY

      connection.execute query
    end
  end

  class Base
    extend UpdateNumerous
  end
end