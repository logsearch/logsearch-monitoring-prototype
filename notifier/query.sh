#!/bin/bash
TODAY=$( date -u +%Y.%m.%d )
NOW=$( date -u +"%Y-%m-%dT%H:%M:%SZ" )
if [ $(uname) == Darwin ]; then
    ONE_MINUTE_AGO=$( date -u -v -61S +"%Y-%m-%dT%H:%M:%SZ")
else
    ONE_MINUTE_AGO=$( date -u -d "-61 seconds" +"%Y-%m-%dT%H:%M:%SZ")
fi

QUERY=$(cat <<EOF
{
   "fields": [
      "@timestamp",
      "@message"
   ],
   "query": {
  	"bool": {
  		"must": [
        {
          "range" : { 
            "@timestamp" : { 
               "from": "$ONE_MINUTE_AGO",
               "to": "$NOW"
            }
          }
        },
  			{
  			   "query_string": {
  			      "query": "has timed out"
  			   }
  			},
  			{
  			   "term": {
  			      "syslog_program": "BOSHHealthMonitor"
  			   }
  			}
  		]
    }
   },
   "size": 1,
   "sort": {
      "@timestamp": "desc"
   }
}
EOF
)
echo $QUERY | curl --silent -d @- -XGET "http://api.meta.logsearch.io:9200/logstash-$TODAY/_search?pretty" 
