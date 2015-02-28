###
# Compass
###
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Proxy Pages
###
data.positions.each do |position|
  proxy "/vagas/#{position.title.parameterize}.html", 'positions/show.html', locals: {position: position}, ignore: true
end

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

###
# Helpers
###
helpers do
  def position_path(position)
    "vagas/#{position.title.parameterize}.html"
  end

  def position_email(position)
    position.email_to || data.site.position.email_to
  end

  def position_subject(position)
    "Vaga - #{position.title}"
  end
end

###
# Configuration
###
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

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
  activate :gzip
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
end
