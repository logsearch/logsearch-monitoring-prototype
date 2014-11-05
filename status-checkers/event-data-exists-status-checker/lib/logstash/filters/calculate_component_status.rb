# Call this file 'foo.rb' (in logstash/filters, as above)
require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::CalculateComponentStatus < LogStash::Filters::Base

  config_name "calculate_component_status"
  milestone 1
  config :component_records, :validate => :string

  public
  def register
    # nothing to do
  end # def register

  public
  def filter(event)
    # return nothing unless there's an actual filter event
    return unless filter?(event)
    return unless event[@component_records]

    old_components = extract_component_keys(event[@component_records][0]["_source"])
    new_components = extract_component_keys(event[@component_records][1]["_source"])
    added_components = new_components - old_components
    old_and_added_components = old_components + added_components
    
    old_and_added_components.each do |component|
       component_state = {
          :key => component,
          :check => "event-data-exists-checker",
          :state => "OK"
       }

       component_state[:state] = "WARN" unless new_components.include? component

       new_event = LogStash::Event.new(component_state)
       filter_matched(new_event)
       yield new_event
    end

    # Cancel the source event, we'll use the newly generated ones above.
    event.cancel
  end # def filter

  protected

  def extract_component_keys(tree, components = []) 
    if tree.has_key?("children") 
      tree["children"].each do |child|
        extract_component_keys(child, components) 
      end
    end
    components << tree["key"]
  end

end # class LogStash::Filters::Foo