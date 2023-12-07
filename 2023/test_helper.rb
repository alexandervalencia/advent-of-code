require "minitest/autorun"
require "minitest/pride"

class Minitest::Test
  def self.described_class
    Object.const_get(name.gsub(/Test(::|$)/, "\\1"))
  end

  def described_class
    self.class.described_class
  end

  def self.test(name, &block)
    test_name = "test_#{name.gsub(/\s+/, "_")}".to_sym
    defined = method_defined? test_name
    raise "#{test_name} is already defined in #{self}" if defined
    if block_given?
      define_method(test_name, &block)
    else
      define_method(
        test_name
      ) { flunk "No implementation provided for #{name}" }
    end
  end
end
