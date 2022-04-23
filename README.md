# Materialized Cache with Redpanda and ksqlDB

## Setting up  
You'll need to have docker and docker-compose installed before getting started.
1. Clone this repo and navigate to the directory as shown below:

```
git clone https://github.com/Ivy-Walobwa/redpanda-ksqldb-materialized-cache.git

cd redpanda-ksqldb-materialized-cache
```


2. Start the stack
```
docker-compose up -d
```
3. Start ksqlDB's interactive CLI

```
docker exec -it ksqldb-cli ksql http://ksqldb-server:8088
```

4. Run initial script
```
RUN SCRIPT '/etc/sql/init.sql';
```

The script does the following:
- Creates a stream
- Creates materialized views

6. Populates stream with events

In the interactive CLI, copy and paste the content of `file/sql/data.sql` to populate stream with data. 

Example;

```
INSERT INTO calls (name, reason, duration_seconds) VALUES ('derek', 'refund', 325);
```

7. Configure ksqlDB to read from start of stream
```
SET 'auto.offset.reset' = 'earliest';
```

7. Make Queries

Start another ksqlDB's interactive CLI and run the query in `files/sql/query-example.sql`. 

Example;

```
SELECT * FROM lifetime_view
WHERE name = 'michael'EMIT CHANGES;
```

8. Add more data to the stream (first CLI instance) and observe the changes in the query (second CLI instance).
