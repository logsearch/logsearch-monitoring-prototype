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
      environment['cluster']['buckets'].each do |cluster|
        cluster['host']['buckets'].each do |host|
          host['service']['buckets'].each do |service|
            service['event_source']['buckets'].each do |event_source|
              new_components << { 
                "@timestamp" => timestamp,
                "_type" => "event_source",
                :name => event_source['key'],
                :key => "#{environment['key']}/#{cluster['key']}/#{host['key']}/#{service['key']}/#{event_source['key']}",
                :host => host['key'],
                :service => service['key'],
                :event_source => event_source['key'],
                #TODO these should be fetched dynamically
                :environment => environment['key'], 
                :cluster => cluster['key']
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
      component[:status_weight] = 1
      component[:status_check] = "logsearchshipper-bosh-event-data-exists-status-checker"
    new_event = LogStash::Event.new(component)
    filter_matched(new_event)
    yield new_event
  end

    # Cancel this event, we'll use the newly generated ones above.
    event.cancel
  end # def filter
end # class LogStash::Filters::Foo