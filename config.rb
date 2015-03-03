###
# Compass
###
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Proxy Pages
###
# proxy "/page.html", 'other-page.html', locals: {name: 'John'}, ignore: true


###
# Plugins
###
activate :dotenv

activate :s3_sync do |config|
  config.bucket                 = 'vagas.estilyngue.com'
  config.region                 = 'sa-east-1'
  config.aws_access_key_id      = ENV.fetch('AWS_ACCESS_KEY_ID')
  config.aws_secret_access_key  = ENV.fetch('AWS_SECRET_ACCESS_KEY')
  config.after_build            = true
end

activate :blog do |blog|
  blog.layout = 'position'
  blog.permalink = '{title}.html'
  blog.sources = 'positions/{title}.html'
end

###
# Helpers
###
# helpers do

# end

###
# Configuration
###
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :relative_links, true

###
# Development
###
configure :development do
  activate :livereload
end

###
# Build
###
configure :build do
  activate :minify_css
  # activate :gzip
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
end
