require "logstash/filters/base"
require "logstash/namespace"
require 'thread_safe'

class LogStash::Filters::ExtractComponents < LogStash::Filters::Base

  config_name "extract_components"
  milestone 1
  config :source, :validate => :string

  public
  def register
	@components = ThreadSafe::Array.new
	#Fill with the existing components
  end # def register

  public
  def filter(event)
    # return nothing unless there's an actual filter event
    return unless filter?(event)
          
    return unless event[@source]

    new_components = []
    timestamp = Time.now.utc
    event[@source]['environment']['buckets'].each do |environment|
    	new_components << {
    		"@timestamp" => timestamp,
			"_type" => "environment",
			:name => environment['key'],
    		:key => "#{environment['key']}",
    		:environment => environment['key']
    	}
    	environment['cluster']['buckets'].each do |cluster|
    		new_components << {
    			"@timestamp" => timestamp,
				"_type" => "cluster",
				:name => cluster['key'],
	    		:key => "#{environment['key']}/#{cluster['key']}",
	    		:environment => environment['key'],
	    		:cluster => cluster['key']
	    	}
    		cluster['host']['buckets'].each do |host|
    			new_components << {
    				"@timestamp" => timestamp,
					"_type" => "host",
					:name => host['key'],
		    		:key => "#{environment['key']}/#{cluster['key']}/#{host['key']}",
		    		:environment => environment['key'],
		    		:cluster => cluster['key'],
		    		:host => host['key']
		    	}
    			host['service']['buckets'].each do |service|
    				new_components << {
    					"@timestamp" => timestamp,
						"_type" => "service",
						:name => service['key'],
			    		:key => "#{environment['key']}/#{cluster['key']}/#{host['key']}/#{service['key']}",
			    		:environment => environment['key'],
			    		:cluster => cluster['key'],
			    		:host => host['key'],
			    		:service => service['key']
			    	}
    				service['event_source']['buckets'].each do |event_source|
				    	new_components << { 
				    		"@timestamp" => timestamp,
				    		"_type" => "event_source",
				    		:name => event_source['key'],
				    		:key => "#{environment['key']}/#{cluster['key']}/#{host['key']}/#{service['key']}/#{event_source['key']}",
				    		:environment => environment['key'],
				    		:cluster => cluster['key'],
				    		:host => host['key'],
				    		:service => service['key'],
				    		:event_source => event_source['key']
				    	}
				    end
			    end
			end
	    end
    end

    @components.each do |component|
    	new_component = new_components.find { |c| c[:key] == component[:key] }
    	#WARN when a component exists in the old, not the new
    	if new_component == nil
    		component[:status] = "WARN"
    	else
    		#OK when a component exists in the old, and the new
    		new_component[:status] = "OK"
    		component = new_component
    	end
    end

    #Add extra new components to the old 
    new_components.each do |new_component|
    	unless @components.any? { |c| c[:key] == new_component[:key] }
    		new_component[:status] = "OK"
    		@components << new_component
    	end
    end

    @components.each do |component|
		new_event = LogStash::Event.new(component)
		filter_matched(new_event)
		yield new_event
	end

    # Cancel this event, we'll use the newly generated ones above.
    event.cancel
  end # def filter
end # class LogStash::Filters::Foo