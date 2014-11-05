#!/bin/bash
while [ 1 ]
do
  TODAY_INDEX=$( date -u +%Y.%m.%d )
  NOW=$( date -u +"%Y-%m-%dT%H:%M:%SZ" )
  if [ $(uname) == Darwin ]; then
    YESTERDAY_INDEX=$( date -u -v -24H +%Y.%m.%d )
    ONE_DAY_AGO=$( date -u -v -24H +"%Y-%m-%dT%H:%M:%SZ")
  else
    YESTERDAY_INDEX=$( date -u -d "-24 hours" +%Y.%m.%d )
    ONE_DAY_AGO=$( date -u -d "-24 hours" +"%Y-%m-%dT%H:%M:%SZ")
  fi

  QUERY=$(cat <<EOF
{
   "query": {
      "bool": {
         "must": [
            {
               "range": {
                  "@timestamp": {
                      "from": "$ONE_DAY_AGO",
                      "to": "$NOW"
                    }
               }
            },            
            {
               "query_string": {
                  "query": "_exists_:@source.bosh_deployment"
               }
            }
         ]
      }
   },
    "aggs" : {
        "environment" : {
            "terms" : { "field" : "@source.bosh_director", "size": 0 },
            "aggs" : {
                "cluster" : {
                    "terms" : { "field" : "@source.bosh_deployment", "size": 0 },
                    "aggs" : {
                        "host" : {
                            "terms" : { "field" : "@source.bosh_job", "size": 0 },
                            "aggs" : {
                                "service" : {
                                    "terms" : { "field" : "@source.bosh_template", "size": 0 },
                                    "aggs" : {
                                        "event_source" : {
                                            "terms" : { "field" : "@source.path", "size": 0}
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
  echo $QUERY | curl --silent -d @- -XGET "http://api.meta.logsearch.io:9200/logstash-$YESTERDAY_INDEX,logstash-$TODAY_INDEX/_search"
  echo #newline

  sleep 600s
done
