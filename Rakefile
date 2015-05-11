require 'rake'
require 'yaml'
require 'kramdown'
require 'erb'
require 'active_support/inflector'

FILE_BASE_NAME = 'Mage_Wars_Codex_DE'

desc 'create Markdown file'
task :markdown do
  yaml = YAML.load_file("#{__dir__}/#{FILE_BASE_NAME}.yml")

  File.open("#{__dir__}/#{FILE_BASE_NAME}.markdown", 'w') do |file|
    yaml['terms'].sort_by{|k, v| ActiveSupport::Inflector.transliterate(v['title'])}.each do |key, value|
      file.write "## <a id='#{key}'></a>#{value['title']}\n\n"
      file.write "#### *#{value['trait']}*\n\n" unless value['trait'].empty?
      file.write "#{value['text']}\n"
    end
  end
end

desc 'create HTML file from template'
task :html do
  html = Kramdown::Document.new(File.read("#{__dir__}/#{FILE_BASE_NAME}.markdown"), {auto_ids: false, template: "#{__dir__}/#{FILE_BASE_NAME}_template.html.erb", hard_wrap: true}).to_html
  File.open("#{__dir__}/#{FILE_BASE_NAME}.html", 'w') do |file|
    file.write html
  end
end

desc 'create TEX file from template'
task :tex do
  @data = YAML.load_file("#{__dir__}/#{FILE_BASE_NAME}.yml")
  erb = ERB.new(File.open("#{__dir__}/#{FILE_BASE_NAME}_template.tex.erb").read, 0, '>')
  File.open("#{__dir__}/#{FILE_BASE_NAME}.tex", 'w') do |file|
    file.write erb.result binding
  end
end

desc 'create PDF file'
task :pdf => [:default] do
  2.times {system ( "/usr/texbin/xelatex #{FILE_BASE_NAME}.tex" )}
end

desc 'create all files needed except the PDF file'
task :default => [:markdown, :html, :tex]
