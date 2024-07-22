module Taxons
  extend self

  def root_taxons
    uri = URI("https://www.gov.uk/api/content")
    response = Net::HTTP.get(uri)

    JSON.parse(response)["links"]["level_one_taxons"]
  end

  def secondary_taxons(root_taxon_id)
    parent = root_taxons.find { |t| t["content_id"] == root_taxon_id }
    uri = URI("https://www.gov.uk/api/content/#{parent['base_path']}")
    response = Net::HTTP.get(uri)

    JSON.parse(response)["links"]["child_taxons"]
  end
end
