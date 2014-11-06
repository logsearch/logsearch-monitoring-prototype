#!/bin/bash
QUERY=$(cat <<EOF
{
  "mappings" : {
    "environment" : {
      "properties" : {
        "@timestamp" : {
          "type" : "date",
          "format" : "dateOptionalTime"
        },
        "@version" : {
          "type" : "string"
        },
        "_type" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "environment" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "key" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "name" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "status" : {
          "type" : "string",
          "index" : "not_analyzed"
        }
      }
    },
    "service" : {
      "properties" : {
        "@timestamp" : {
          "type" : "date",
          "format" : "dateOptionalTime"
        },
        "@version" : {
          "type" : "string"
        },
        "_type" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "cluster" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "environment" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "host" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "key" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "service" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "name" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "status" : {
          "type" : "string",
          "index" : "not_analyzed"
        }
      }
    },
    "host" : {
      "properties" : {
        "@timestamp" : {
          "type" : "date",
          "format" : "dateOptionalTime"
        },
        "@version" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "_type" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "cluster" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "environment" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "host" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "key" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "name" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "status" : {
          "type" : "string",
          "index" : "not_analyzed"
        }
      }
    },
    "event_source" : {
      "properties" : {
        "@timestamp" : {
          "type" : "date",
          "format" : "dateOptionalTime"
        },
        "@version" : {
          "type" : "string"
        },
        "_type" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "cluster" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "environment" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "event_source" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "host" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "key" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "service" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "name" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "status" : {
          "type" : "string",
          "index" : "not_analyzed"
        }
      }
    },
    "cluster" : {
      "properties" : {
        "@timestamp" : {
          "type" : "date",
          "format" : "dateOptionalTime"
        },
        "@version" : {
          "type" : "string"
        },
        "_type" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "cluster" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "environment" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "key" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "name" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "status" : {
          "type" : "string",
          "index" : "not_analyzed"
        }
      }
    }
  }
}
EOF
  )
  curl --silent -XDELETE 'http://api.meta.logsearch.io:9200/.components'
  echo $QUERY | curl --silent -d @- -XPOST "http://api.meta.logsearch.io:9200/.components"