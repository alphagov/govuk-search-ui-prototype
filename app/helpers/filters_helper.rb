module FiltersHelper
  FILTERABLE_PARAMS = %w[
    content_purpose_supergroups
    primary_topic
    secondary_topic
  ].freeze

  SUPERGROUPS = {
    "services" => "Services",
    "guidance_and_regulation" => "Guidance and regulation",
    "news_and_communications" => "News and communications",
    "research_and_statistics" => "Research and statistics",
    "policy_and_engagement" => "Policy papers and consultations",
    "transparency" => "Transparency and freedom of information releases",
  }.freeze

  def filter_remove_links
    [].tap { |links|
      if permitted_params[:primary_topic].present?
        primary_topic_title = Rails.configuration.govuk_taxons.dig(
          permitted_params[:primary_topic], "title"
        )

        links << filter_remove_link(
          "Topic: #{primary_topic_title}",
          url_for(permitted_params.except(:primary_topic, :secondary_topic)),
        )
      end

      if permitted_params[:secondary_topic].present?
        secondary_topic_title = Rails.configuration.govuk_taxons.dig(
          permitted_params[:primary_topic], "children", permitted_params[:secondary_topic], "title"
        )
        links << filter_remove_link(
          "Sub-topic: #{secondary_topic_title}",
          url_for(permitted_params.except(:secondary_topic)),
        )
      end

      if permitted_params[:content_purpose_supergroups].present?
        links << permitted_params[:content_purpose_supergroups].map do |value|
          filter_remove_link(
            "Type: #{SUPERGROUPS[value]}",
            url_for(permitted_params.merge(content_purpose_supergroups: permitted_params[:content_purpose_supergroups] - [value])),
          )
        end
      end
    }.flatten
  end

  def filter_remove_link(text, link)
    link_to(link, class: "facet-tag") do
      tag.span("Remove filter", class: "govuk-visually-hidden") +
        tag.span(text, class: "facet-tag__text")
    end
  end

  def clear_all_filter_path
    url_for(permitted_params.except(*FILTERABLE_PARAMS))
  end

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
