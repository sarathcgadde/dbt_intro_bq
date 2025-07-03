{% macro compute_date_diff(end_time, start_time) %}

COALESCE(DATE_DIFF({{ end_time }}, {{ start_time }}, DAY), 0)

{%- endmacro %}