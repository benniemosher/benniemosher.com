###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

set :haml, ugly: true, format: :html5
set :markdown, fenced_code_blocks: true, smartypants: true

activate :directory_indexes

Time.zone = 'America/Denver'

activate :blog do |blog|
	blog.prefix = 'blog'
	blog.paginate = true
	blog.per_page = 5
end

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
	activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
	# Minify CSS on build
	activate :minify_css

	# Minify Javascript on build
	activate :minify_javascript
end
