require "erb"
require "json"

$ ruby scripts/add_collection.rb mutated_monke mutated_monkes "" ""


# Get ids from the console command and do some cleanup
collection = {
  moonrank: mutated_monke,
  magic_eden: mutated_monkes,
  solanart: null,
  alpha_art: null
}
collection.transform_values! do |id|
  id == "" ? nil : id
end

# Update the collection index
collection_index_filename = File.join(File.dirname(__FILE__), "../.github/collections.json")
collection_index = JSON.parse File.open(collection_index_filename).read

collection_index.push(collection)

File.open(collection_index_filename, "w") do |collection_index_file|
  collection_index_file.write JSON.pretty_generate(collection_index)
end

# Re-generate the Github Actions workflow
require_relative "generate_workflow"

# Create axios config files for Alpha Art marketplace
require_relative "generate_axios_configs"

# Process moonrank data
require_relative "process_moonrank_data"
