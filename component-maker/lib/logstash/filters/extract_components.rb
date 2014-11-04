# Call this file 'foo.rb' (in logstash/filters, as above)
require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::ExtractComponents < LogStash::Filters::Base

  config_name "extract_components"
  milestone 1
  config :source, :validate => :string

  public
  def register
    # nothing to do
  end # def register

  public
  def filter(event)
    # return nothing unless there's an actual filter event
    return unless filter?(event)
          
    return unless event[@source]
    
    event[@source]['environment']['buckets'].each do |environment|
    	environment_children = []
    	environment['cluster']['buckets'].each do |cluster|
    		cluster_children = []
    		cluster['host']['buckets'].each do |host|
    			host_children = []
    			host['service']['buckets'].each do |service|
    				service_children = []
    				service['event_source']['buckets'].each do |event_source|
				    	component = { 
				    		"_type" => "event_source",
				    		:key => "#{environment['key']}/#{cluster['key']}/#{host['key']}/#{service['key']}/#{event_source['key']}",
				    		:environment => environment['key'],
				    		:cluster => cluster['key'],
				    		:host => host['key'],
				    		:service => service['key'],
				    		:event_source => event_source['key']
				    	}
				    	service_children << component
				    	new_event = LogStash::Event.new(component)
				    	filter_matched(new_event)
				    	yield new_event
				    end
				    component = { 
						"_type" => "service",
			    		:key => "#{environment['key']}/#{cluster['key']}/#{host['key']}/#{service['key']}",
			    		:environment => environment['key'],
			    		:cluster => cluster['key'],
			    		:host => host['key'],
			    		:service => service['key'],
			    		:children => service_children
			    	}
			    	host_children << component
			    	new_event = LogStash::Event.new(component)
			    	filter_matched(new_event)
			    	yield new_event
			    end
			    component = { 
					"_type" => "host",
		    		:key => "#{environment['key']}/#{cluster['key']}/#{host['key']}",
		    		:environment => environment['key'],
		    		:cluster => cluster['key'],
		    		:host => host['key'],
		    		:children => host_children
		    	}
		    	cluster_children << component
		    	new_event = LogStash::Event.new(component)
		    	filter_matched(new_event)
		    	yield new_event
			end
			component = { 
				"_type" => "cluster",
	    		:key => "#{environment['key']}/#{cluster['key']}",
	    		:environment => environment['key'],
	    		:cluster => cluster['key'],
	    		:children => cluster_children
	    	}
	    	environment_children << component
	    	new_event = LogStash::Event.new(component)
	    	filter_matched(new_event)
	    	yield new_event
	    end
	    component = { 
			"_type" => "environment",
    		:key => "#{environment['key']}",
    		:environment => environment['key'],
    		:children => environment_children
    	}
    	new_event = LogStash::Event.new(component)
    	filter_matched(new_event)
    	yield new_event
    end

    # .each do |item|
    #   puts item
    #   new_event = LogStash::Event.new(item)

    #   filter_matched(new_event)

    #   # Push this new event onto the stack at the LogStash::FilterWorker
    #   yield new_event
    # end

    # Cancel this event, we'll use the newly generated ones above.
    event.cancel
  end # def filter
end # class LogStash::Filters::Foo