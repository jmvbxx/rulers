# frozen_string_literal: true

# object class
class Object
  def self.const_missing(const)
    @calling_const_missing ||= {}
    return nil if @calling_const_missing[const]

    @calling_const_missing[const] = true
    require Rulers.to_underscore(const.to_s)
    klass = Object.const_get(const)
    @calling_const_missing[const] = false

    klass
  end

  # Comment on Chapter 3, Exercise 1
  # My first reaction was to test the existence of the constant by using `Object.const_defined?("CONSTANT")`.
  # The reasoning behind this was the comment in the book about Rails checking whether or not the constant exists
  # before loading the file.
  #
  # Aside from that I struggled with this question and was forced to copy the provided answer. Admittedly, I am not
  # familiar with mutexes in Ruby and I will need to investigate this topic in detail
end
