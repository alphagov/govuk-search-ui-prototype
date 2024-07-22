module FiltersHelper
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
