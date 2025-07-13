require Rails.root.join("lib/time_helpers")

Time.prepend(TimeHelpers)
