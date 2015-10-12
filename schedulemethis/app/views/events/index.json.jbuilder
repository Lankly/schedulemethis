json.array!(@events) do |event|
  json.extract! event, :id
  json.title event.short_description
  json.start event.get_start_datetime
  json.end event.get_end_time
  json.url event_url(event, format: :html)
end
