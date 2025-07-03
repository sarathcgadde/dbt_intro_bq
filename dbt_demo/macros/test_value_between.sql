{% macro test_value_between(model, column_name, min_value, max_value) %}
    SELECT *
    FROM {{ model }}
    WHERE {{ column_name }} >= {{ min_value }}
      AND {{ column_name }} <= {{ max_value }}
{% endmacro %}