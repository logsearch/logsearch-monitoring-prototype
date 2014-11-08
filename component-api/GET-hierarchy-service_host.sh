#!/bin/bash
QUERY=$(cat <<EOF
{
   "query": {
      "bool": {
         "must": [        
            {
               "query_string": {
                  "query": "*"
               }
            }
         ]
      }
   },
    "aggs" : {
        "service" : {
            "terms" : { "field" : "service", "size": 0 },
            "aggs" : {
               "host" : {
                   "terms" : { "field" : "host", "size": 0 }
                }
            }
        }
    },
   "size": 0
}
EOF
)

echo $QUERY | curl --silent -d @- -XGET "http://api.meta.logsearch.io:9200/.component-status/_search?pretty"
