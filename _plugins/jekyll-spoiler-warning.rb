# frozen_string_literal: true

module Jekyll
  # Automatically flags posts as containing spoilers based on categories/tags
  # configured under `spoiler_warning:` in _config.yml. Posts can also be
  # explicitly opted in or out via `spoiler_warning: true/false` in front matter.
  #
  # _config.yml example:
  #   spoiler_warning:
  #     enabled: true
  #     categories:
  #       - book
  #       - reviews
  #     tags:
  #       - spoilers
  #     title: "Spoiler Warning"
  #     message: "This post contains spoilers."
  #     confirm_text: "Continue Reading"
  #     cancel_text: "← Go Back"
  #
  # To package as a gem: move this file into lib/jekyll-spoiler-warning.rb,
  # add require in a plugins/ entry point, and ship _includes/spoiler-modal.html
  # + assets/js/spoiler-warning.js as documented copy steps in your README.
  class SpoilerWarningGenerator < Generator
    safe true
    priority :normal

    def generate(site)
      config = site.config["spoiler_warning"] || {}
      return if config["enabled"] == false

      trigger_categories = normalize(config["categories"])
      trigger_tags = normalize(config["tags"])

      site.posts.docs.each do |post|
        next if post.data["spoiler_warning"] == false

        already_flagged = post.data["spoiler_warning"] == true
        post_cats = normalize(post.data["categories"])
        post_tags = normalize(post.data["tags"])

        matches = already_flagged ||
                  intersects?(post_cats, trigger_categories) ||
                  intersects?(post_tags, trigger_tags)

        post.data["spoiler_warning"] = matches
      end
    end

    private

    def normalize(values)
      Array(values).map(&:to_s).map(&:downcase)
    end

    def intersects?(a, b)
      !(a & b).empty?
    end
  end
end
