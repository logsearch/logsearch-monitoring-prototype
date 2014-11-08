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
        "environment" : {
            "terms" : { "field" : "environment", "size": 0 },
            "aggs" : {
                "cluster" : {
                    "terms" : { "field" : "cluster", "size": 0 },
                    "aggs" : {
                        "host" : {
                            "terms" : { "field" : "host", "size": 0 },
                            "aggs" : {
                                "service" : {
                                    "terms" : { "field" : "service", "size": 0 },
                                    "aggs" : {
                                        "event_source" : {
                                            "terms" : { "field" : "event_source", "size": 0}
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    },
   "size": 0
}
EOF
)

echo $QUERY | curl --silent -d @- -XGET "http://api.meta.logsearch.io:9200/.component-status/_search?pretty"
