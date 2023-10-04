

def unflatten_dict(data, result = {}, sep = ".")
  data.to_hash.each do |key, value|
    keys = key.split(sep, 2)
    if keys.length > 1
      result[keys[0]] = {} unless result.keys.include?(keys[0])
      unflatten_dict({keys[1] => value}, result[keys[0]], sep = sep)
    else
      result[key] = value
    end
  end
  return result
end

def clean_data_from_null_values(data)
  clean = {}
  for k, v in data.items
    if v.is_a? Hash
      v = clean_data_from_null_values(v)
    end
    next if v.nil? || v.empty? || v == "nan" || v == ""
    if v.is_a? String
      v = v.downcase
      v = true if v == "true"
      v = false if v == "false"
    end
    clean[k] = v
  end
  clean
end


tmp = clean_data_from_null_values(unflatten_dict(event))
  event.cancel
  new_custom_event = LogStash::Event.new()
  tmp.each do |key, value|
    new_custom_event.set(key, value)
  end
  new_event_block.call(new_custom_event)
end
