def clean_data_from_null_values(data)
  clean = {}
  for k, v in data.items
    if v.is_a? Hash
      v = clean_data_from_null_values(v)
    end
    if v.nil? || v.empty? || v == "nan" || v == ""
      next
    end
    if v.is_a? String
      v = v.downcase
      v = true if v == "true"
      v = false if v == "false"
    end
    clean[k] = v
  end
  clean
end

.
