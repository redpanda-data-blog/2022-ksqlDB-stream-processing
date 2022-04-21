CREATE STREAM calls (name VARCHAR, reason VARCHAR, duration_seconds INT)
  WITH (kafka_topic='call-center', value_format='json', partitions=1);


CREATE TABLE support_view AS
    SELECT name,
           count_distinct(reason) AS distinct_reasons,
           latest_by_offset(reason) AS last_reason
    FROM calls
    GROUP BY name
    EMIT CHANGES;


CREATE TABLE lifetime_view AS
    SELECT name,
           count(reason) AS total_calls,
           (sum(duration_seconds) / 60) as minutes_engaged
    FROM calls
    GROUP BY name
    EMIT CHANGES;





