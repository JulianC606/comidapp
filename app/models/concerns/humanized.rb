# frozen_string_literal: true

module Humanized
  def human_class_name(...)
    self.class.model_name.human(...)
  end

  def human_attribute_name(...)
    self.class.human_attribute_name(...)
  end
end
