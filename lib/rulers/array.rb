# frozen_string_literal: true

# Adds up the values in an array
class Array
  def sum(start = 0)
    inject(start, &:+)
  end
end
