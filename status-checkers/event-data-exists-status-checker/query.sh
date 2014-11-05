#!/bin/bash
while [ 1 ]
do
  QUERY=$(cat <<EOF
{
 "query": {
    "bool": {
       "must": [
          {
             "term" : { "_type" : "environment" }
          },
          {
             "term" : { "key" : "bosh-meta-logsearch-io" }
          }
       ]
    }
 },
 "sort": { "@timestamp": { "order": "asc" }},
 "size": 2
}
EOF
  )
  echo $QUERY | curl --silent -d @- -XGET "http://api.meta.logsearch.io:9200/.components/_search"
  echo #newline

  sleep 60s
done
