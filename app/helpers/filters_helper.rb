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
      Rails.configuration.govuk_taxons
        .map do |content_id, data|
          {
            value: content_id,
            text: data["title"],
            selected: content_id == selected_id,
          }
        end
  end

  def secondary_topics_options(parent_id, selected_id = nil)
    return [{ value: "", text: "All sub-topics" }] if parent_id.blank?

    [{ value: "", text: "All sub-topics" }] +
      Rails.configuration.govuk_taxons[parent_id]["children"]
        .map do |content_id, data|
          {
            value: content_id,
            text: data["title"],
            selected: content_id == selected_id,
          }
        end
  end
end
