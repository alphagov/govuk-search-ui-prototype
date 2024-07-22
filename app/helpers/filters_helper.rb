module FiltersHelper
  SUPERGROUPS = {
    "services" => "Services",
    "guidance_and_regulation" => "Guidance and regulation",
    "news_and_communications" => "News and communications",
    "research_and_statistics" => "Research and statistics",
    "policy_and_engagement" => "Policy papers and consultations",
    "transparency" => "Transparency and freedom of information releases",
  }

  def supergroup_options(selected_values)
    selected_values ||= []

    SUPERGROUPS.map do |value, label|
      {
        label:,
        value:,
        checked: selected_values.include?(value),
      }
    end
  end

  def primary_topics_options(selected_id = nil)
    [{ value: "", text: "All topics" }] +
      Taxons
        .root_taxons
        .map { |taxon|
          {
            value: taxon["content_id"],
            text: taxon["title"],
            selected: taxon["content_id"] == selected_id,
          }
        }
        .sort_by { |obj| obj[:text] }
  end

  def secondary_topics_options(parent_id, selected_id = nil)
    return [{ value: "", text: "All sub-topics" }] if parent_id.blank?

    [{ value: "", text: "All sub-topics" }] +
      Taxons
        .secondary_taxons(parent_id)
        .map { |taxon|
          {
            value: taxon["content_id"],
            text: taxon["title"],
            selected: taxon["content_id"] == selected_id,
          }
        }
        .sort_by { |obj| obj[:text] }
  end
end
