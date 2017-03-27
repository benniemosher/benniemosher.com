# Set the time zone
Time.zone = 'America/Denver'

# ------------------------------------------------------------------------
# Formatters
# ------------------------------------------------------------------------

# Set up haml processor
set :haml, ugly: true, format: :html5

# Set up markdown processor
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true

# ------------------------------------------------------------------------
# Blog Settings
# ------------------------------------------------------------------------
activate :blog do |blog|
  blog.name = 'blog'
  blog.prefix = 'posts'
  blog.paginate = true
  blog.per_page = 5
end

activate :blog do |resume|
  resume.name = 'resume'
  resume.prefix = 'jobs'
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

activate :deploy do |deploy|
  deploy.method = :rsync
  # host and path *must* be set
  deploy.host = 'benniemosher.com'
  deploy.path = '/usr/share/nginx/html/benniemosher.com'
  # user is optional (no default)
  deploy.user = 'benniemosher'
  # port is optional (default is 22)
  # deploy.port  = 5309
  # clean is optional (default is false)
  deploy.clean = true
  # flags is optional (default is -avze)
  # deploy.flags = "-rltgoDvzO --no-p --del -e"
  deploy.build_before = true
end

# Use LiveReload
activate :livereload

# Use autoprefixer
activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
end

# Use Search Engine Sitemap
set :url_root, data.config.site.root_url
activate :sitemap, hostname: 'https://benniemosher.com'

# User Bower to manage vendor scripts
# activate :bower

# Automatic image dimensions on image_tag helper (only works with local images)
activate :automatic_image_sizes

set :partials_dir, 'partials'

activate :syntax, line_numbers: true

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
  # activate :gzip

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
