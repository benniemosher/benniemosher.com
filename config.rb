# Set the time zone
Time.zone = 'America/Denver'

# ------------------------------------------------------------------------
# Formatters
# ------------------------------------------------------------------------

# Set up Haml and Markdown processors
set :haml, ugly: true, format: :html5
set :markdown, fenced_code_blocks: true, smartypants: true

# ------------------------------------------------------------------------
# Blog Settings
# ------------------------------------------------------------------------
activate :blog do |blog|
  blog.name = 'blog'
  blog.prefix = 'blog'
  blog.paginate = true
  blog.per_page = 5
end

activate :blog do |blog|
  blog.name = 'resume'
  blog.prefix = 'jobs'
end

# ------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------

helpers do
  # Helpers are defined in and can be added to `helpers/custom_helpers.rb`.
  # In case you require helpers within `config.rb`, they can be added here.
end

# ------------------------------------------------------------------------
# Extensions
# ------------------------------------------------------------------------

# Use LiveReload
activate :livereload

# Use autoprefixer
activate :autoprefixer

# Use Search Engine Sitemap
set :url_root, data.config.site.root_url
activate :search_engine_sitemap

# User Bower to manage vendor scripts
# activate :bower

# Automatic image dimensions on image_tag helper (only works with local images)
activate :automatic_image_sizes

# ------------------------------------------------------------------------
# Paths
# ------------------------------------------------------------------------

set :css_dir,       'stylesheets'
set :fonts_dir,     'fonts'
set :images_dir,    'images'
set :js_dir,        'javascripts'

# Pretty URLs - See https://middlemanapp.com/advanced/pretty_urls/
activate :directory_indexes

# ------------------------------------------------------------------------
# Build configuration
# ------------------------------------------------------------------------

configure :build do
  # Exclude any vendor components (bower or custom builds) in the build
  ignore 'stylesheets/vendor/*'
  ignore 'javascripts/vendor/*'

  # Activate gzip compression
  activate :gzip

  # Minify CSS
  activate :minify_css

  # Minify Javascript
  activate :minify_javascript

  # Minify HTML
  activate :minify_html,
           remove_http_protocol: false,
           remove_https_protocol: false,
           remove_input_attributes: false,
           remove_quotes: false

  # Compress images (default)
  require 'middleman-smusher'
  activate :smusher

  # Compress ALL images (advanced)
  # Before activating the below, follow setup instructions on https://github.com/toy/image_optim
  # activate :imageoptim do |options|
  #   options.pngout = false # set to true when pngout is also installed
  # end

  # Uniquely-named assets (cache buster)
  # Exception: svg & png in images folder because they need to be
  # interchangeable by JS
  activate :asset_hash, ignore: [%r({/images\/(.*\.png|.*\.svg)/})]
end
