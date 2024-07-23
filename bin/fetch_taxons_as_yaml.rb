#!/usr/bin/env ruby

require File.expand_path('../../config/environment', __FILE__)
require 'net/http'
require 'yaml'

def fetch_json(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
rescue StandardError => e
  Rails.logger.error "Error fetching data from #{url}: #{e.message}"
  nil
end

def process_taxon(taxon)
  base_path = taxon['base_path']
  api_url = "https://www.gov.uk/api/content#{base_path}"

  child_taxons_data = fetch_json(api_url)
  child_taxons = child_taxons_data&.dig('links', 'child_taxons') || []

  children = child_taxons.each_with_object({}) do |child, hash|
    hash[child['content_id']] = { 'title' => child['title'] }
  end

  {
    taxon['content_id'] => {
      'title' => taxon['title'],
      'children' => children
    }
  }
end

# Fetch top-level taxons
Rails.logger.info "Fetching top-level taxons..."
top_level_data = fetch_json('https://www.gov.uk/api/content')

if top_level_data.nil?
  Rails.logger.error "Failed to fetch top-level taxons. Exiting."
  exit 1
end

top_level_taxons = top_level_data.dig('links', 'level_one_taxons') || []

Rails.logger.info "Processing #{top_level_taxons.size} top-level taxons..."

# Process each top-level taxon and combine into a single hash
result = top_level_taxons.each_with_object({}) do |taxon, hash|
  Rails.logger.info "Processing taxon: #{taxon['title']}"
  hash.merge!(process_taxon(taxon))
end

# Sort the top-level hash by title
result = result.sort_by { |_, v| v['title'] }.to_h

# Sort children of each taxon by title
result.each do |_, taxon|
  taxon['children'] = taxon['children'].sort_by { |_, v| v['title'] }.to_h
end

# Output the result as YAML to the Rails config folder
output_path = Rails.root.join('config', 'govuk_taxons.yml')
File.open(output_path, 'w') do |file|
  file.write(result.to_yaml)
end

Rails.logger.info "YAML output saved to #{output_path}"
