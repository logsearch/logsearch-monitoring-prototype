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
          "type" : "string"
        },
        "children" : {
          "properties" : {
            "@timestamp" : {
              "type" : "date",
              "format" : "dateOptionalTime"
            },
            "@version" : {
              "type" : "string"
            },
            "_type" : {
              "type" : "string"
            },
            "children" : {
              "properties" : {
                "@timestamp" : {
                  "type" : "date",
                  "format" : "dateOptionalTime"
                },
                "@version" : {
                  "type" : "string"
                },
                "_type" : {
                  "type" : "string"
                },
                "children" : {
                  "properties" : {
                    "@timestamp" : {
                      "type" : "date",
                      "format" : "dateOptionalTime"
                    },
                    "@version" : {
                      "type" : "string"
                    },
                    "_type" : {
                      "type" : "string"
                    },
                    "children" : {
                      "properties" : {
                        "@timestamp" : {
                          "type" : "date",
                          "format" : "dateOptionalTime"
                        },
                        "@version" : {
                          "type" : "string"
                        },
                        "_type" : {
                          "type" : "string"
                        },
                        "cluster" : {
                          "type" : "string"
                        },
                        "environment" : {
                          "type" : "string"
                        },
                        "event_source" : {
                          "type" : "string"
                        },
                        "host" : {
                          "type" : "string"
                        },
                        "key" : {
                          "type" : "string"
                        },
                        "service" : {
                          "type" : "string"
                        }
                      }
                    },
                    "cluster" : {
                      "type" : "string"
                    },
                    "environment" : {
                      "type" : "string"
                    },
                    "host" : {
                      "type" : "string"
                    },
                    "key" : {
                      "type" : "string"
                    },
                    "service" : {
                      "type" : "string"
                    }
                  }
                },
                "cluster" : {
                  "type" : "string"
                },
                "environment" : {
                  "type" : "string"
                },
                "host" : {
                  "type" : "string"
                },
                "key" : {
                  "type" : "string"
                }
              }
            },
            "cluster" : {
              "type" : "string"
            },
            "environment" : {
              "type" : "string"
            },
            "key" : {
              "type" : "string"
            }
          }
        },
        "environment" : {
          "type" : "string"
        },
        "key" : {
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
          "type" : "string"
        },
        "children" : {
          "properties" : {
            "@timestamp" : {
              "type" : "date",
              "format" : "dateOptionalTime"
            },
            "@version" : {
              "type" : "string"
            },
            "_type" : {
              "type" : "string"
            },
            "cluster" : {
              "type" : "string"
            },
            "environment" : {
              "type" : "string"
            },
            "event_source" : {
              "type" : "string"
            },
            "host" : {
              "type" : "string"
            },
            "key" : {
              "type" : "string"
            },
            "service" : {
              "type" : "string"
            }
          }
        },
        "cluster" : {
          "type" : "string"
        },
        "environment" : {
          "type" : "string"
        },
        "host" : {
          "type" : "string"
        },
        "key" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "service" : {
          "type" : "string"
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
          "type" : "string"
        },
        "_type" : {
          "type" : "string"
        },
        "children" : {
          "properties" : {
            "@timestamp" : {
              "type" : "date",
              "format" : "dateOptionalTime"
            },
            "@version" : {
              "type" : "string"
            },
            "_type" : {
              "type" : "string"
            },
            "children" : {
              "properties" : {
                "@timestamp" : {
                  "type" : "date",
                  "format" : "dateOptionalTime"
                },
                "@version" : {
                  "type" : "string"
                },
                "_type" : {
                  "type" : "string"
                },
                "cluster" : {
                  "type" : "string"
                },
                "environment" : {
                  "type" : "string"
                },
                "event_source" : {
                  "type" : "string"
                },
                "host" : {
                  "type" : "string"
                },
                "key" : {
                  "type" : "string"
                },
                "service" : {
                  "type" : "string"
                }
              }
            },
            "cluster" : {
              "type" : "string"
            },
            "environment" : {
              "type" : "string"
            },
            "host" : {
              "type" : "string"
            },
            "key" : {
              "type" : "string"
            },
            "service" : {
              "type" : "string"
            }
          }
        },
        "cluster" : {
          "type" : "string"
        },
        "environment" : {
          "type" : "string"
        },
        "host" : {
          "type" : "string"
        },
        "key" : {
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
          "type" : "string"
        },
        "cluster" : {
          "type" : "string"
        },
        "environment" : {
          "type" : "string"
        },
        "event_source" : {
          "type" : "string"
        },
        "host" : {
          "type" : "string"
        },
        "key" : {
          "type" : "string",
          "index" : "not_analyzed"
        },
        "service" : {
          "type" : "string"
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
          "type" : "string"
        },
        "children" : {
          "properties" : {
            "@timestamp" : {
              "type" : "date",
              "format" : "dateOptionalTime"
            },
            "@version" : {
              "type" : "string"
            },
            "_type" : {
              "type" : "string"
            },
            "children" : {
              "properties" : {
                "@timestamp" : {
                  "type" : "date",
                  "format" : "dateOptionalTime"
                },
                "@version" : {
                  "type" : "string"
                },
                "_type" : {
                  "type" : "string"
                },
                "children" : {
                  "properties" : {
                    "@timestamp" : {
                      "type" : "date",
                      "format" : "dateOptionalTime"
                    },
                    "@version" : {
                      "type" : "string"
                    },
                    "_type" : {
                      "type" : "string"
                    },
                    "cluster" : {
                      "type" : "string"
                    },
                    "environment" : {
                      "type" : "string"
                    },
                    "event_source" : {
                      "type" : "string"
                    },
                    "host" : {
                      "type" : "string"
                    },
                    "key" : {
                      "type" : "string"
                    },
                    "service" : {
                      "type" : "string"
                    }
                  }
                },
                "cluster" : {
                  "type" : "string"
                },
                "environment" : {
                  "type" : "string"
                },
                "host" : {
                  "type" : "string"
                },
                "key" : {
                  "type" : "string"
                },
                "service" : {
                  "type" : "string"
                }
              }
            },
            "cluster" : {
              "type" : "string"
            },
            "environment" : {
              "type" : "string"
            },
            "host" : {
              "type" : "string"
            },
            "key" : {
              "type" : "string"
            }
          }
        },
        "cluster" : {
          "type" : "string"
        },
        "environment" : {
          "type" : "string"
        },
        "key" : {
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