require 'active_support'
require 'yaml'

FILE_BASE_NAME = 'Mage_Wars_Codex_DE'

def deeply_sort_hash(object)
  return object unless object.is_a?(Hash)
  hash = RUBY_VERSION >= '1.9' ? Hash.new : ActiveSupport::OrderedHash.new
  object.each { |k, v| hash[k] = deeply_sort_hash(v) }
  sorted = hash.sort { |a, b| a[0].to_s <=> b[0].to_s }
  hash.class[sorted]
end

yaml = YAML.load_file("#{__dir__}/#{FILE_BASE_NAME}.yml")

File.open("#{__dir__}/#{FILE_BASE_NAME}_SORTED.yml", 'w') do |file|
  file.write deeply_sort_hash(yaml['terms']).to_yaml
end
