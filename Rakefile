#!/usr/bin/env ruby
# -*- ruby -*-

require 'rake/clean'
begin
  require 'rdoc/task'
rescue LoadError => ex
  # No rdoc task availble.
end

SRC_DIR = 'src'
PROB_DIR = 'koans'
HTML_DIR = 'html'
TEMPLATE_DIR = 'templates'
DIST_DIR = 'dist'
IMAGE_DIR = "#{HTML_DIR}/images"

SRC_FILES = FileList["#{SRC_DIR}/*"]
KOAN_FILES = SRC_FILES.pathmap("#{PROB_DIR}/%f")
TEMPLATE_FILES = FileList["#{TEMPLATE_DIR}/*"]
HTML_FILES = TEMPLATE_FILES.pathmap("#{HTML_DIR}/%f")
TEMPLATE_IMAGE_FILES = FileList["#{TEMPLATE_DIR}/resources/images/*"]
IMAGE_FILES = TEMPLATE_IMAGE_FILES.pathmap("#{IMAGE_DIR}/%f")

today = Time.now.strftime("%Y-%m-%d")
TAR_FILE = "#{DIST_DIR}/rubykoans-#{today}.tgz"
ZIP_FILE = "#{DIST_DIR}/rubykoans-#{today}.zip"

CLEAN.include("**/*.rbc")
CLOBBER.include(DIST_DIR)

module Koans
  extend Rake::DSL if defined?(Rake::DSL)

  # Remove solution info from source
  #   __(a,b)     => __
  #   _n_(number) => __
  #   # __        =>
  def Koans.remove_solution(line)
    line = line.gsub(/\b____\([^\)]+\)/, "____")
    line = line.gsub(/\b___\([^\)]+\)/, "___")
    line = line.gsub(/\b__\([^\)]+\)/, "__")
    line = line.gsub(/\b_n_\([^\)]+\)/, "_n_")
    line = line.gsub(%r(/\#\{__\}/), "/__/")
    line = line.gsub(/\s*#\s*__\s*$/, '')
    line
  end

  def Koans.make_koan_file(infile, outfile)
    if infile =~ /edgecase/
      cp infile, outfile
    else
      open(infile) do |ins|
        open(outfile, "w") do |outs|
          state = :copy
          ins.each do |line|
            state = :skip if line =~ /^ *#--/
            case state
              when :copy
                outs.puts remove_solution(line)
              else
                # do nothing
            end
            state = :copy if line =~ /^ *#\+\+/
          end
        end
      end
    end
  end
end


module Templates
  extend Rake::DSL if defined?(Rake::DSL)
  def Templates.make_template(infile, outfile)
    open(outfile.sub('.rb', '.html'), "w") do |outs|
      outs.puts `ruby #{infile}`
    end
  end

  def Templates.move_image(infile, outfile)
    cp infile, outfile
  end
end

module RubyImpls
  # Calculate the list of relevant Ruby implementations.
  def self.find_ruby_impls
    rubys = `rvm list`.gsub(/=>/, '').split(/\n/).map { |x| x.strip }.reject { |x| x.empty? || x =~ /^rvm/ }.sort
    expected.map { |impl|
      last = rubys.grep(Regexp.new(Regexp.quote(impl))).last
      last ? last.split.first : nil
    }.compact
  end

  # Return a (cached) list of relevant Ruby implementations.
  def self.list
    @list ||= find_ruby_impls
  end

  # List of expected ruby implementations.
  def self.expected
    %w(ruby-1.8.7 ruby-1.9.2 jruby ree)
  end
end

task :default => :walk_the_path

task :walk_the_path do
  cd PROB_DIR
  ruby 'path_to_enlightenment.rb'
end

if defined?(Rake::RDocTask)
  Rake::RDocTask.new do |rd|
    rd.main = "README.rdoc"
    rd.rdoc_files.include("README.rdoc", "${PROB_DIR}/*.rb")
  end
end

directory DIST_DIR
directory PROB_DIR
directory HTML_DIR
directory IMAGE_DIR


desc "Generate the Koans from the source files from scratch."
task :regen => [:clobber_koans, :gen]

desc "Generate the Koans from the changed source files."
task :gen => [:gen_koans, :gen_html, :gen_html_images]
task :gen_koans => KOAN_FILES + [PROB_DIR + "/README.rdoc"]
task :gen_html => HTML_FILES + [HTML_DIR]
task :gen_html_images => IMAGE_FILES + [IMAGE_DIR]

task :clobber_koans do
  rm_r PROB_DIR
end

file PROB_DIR + "/README.rdoc" => "README.rdoc" do |t|
  cp "README.rdoc", t.name
end

SRC_FILES.each do |koan_src|
  file koan_src.pathmap("#{PROB_DIR}/%f") => [PROB_DIR, koan_src] do |t|
    Koans.make_koan_file koan_src, t.name
  end
end

TEMPLATE_FILES.each do |html_template|
  file html_template.pathmap("#{HTML_DIR}/%f") => [HTML_DIR, html_template] do |t|
    Templates.make_template(html_template, t.name) unless t.name =~ /resources/
  end
end

TEMPLATE_IMAGE_FILES.each do |image|
  file image.pathmap("#{IMAGE_DIR}/%f") => [IMAGE_DIR, image] do |t|
    Templates.move_image(image, t.name)
  end
end


task :run do
  puts 'koans'
  Dir.chdir("${SRC_DIR}") do
    puts "in #{Dir.pwd}"
    sh "ruby path_to_enlightenment.rb"
  end
end


desc "Pre-checkin tests (=> run_all)"
task :cruise => :run_all

desc "Run the completed koans againts a list of relevant Ruby Implementations"
task :run_all do
  results = []
  RubyImpls.list.each do |impl|
    puts "=" * 40
    puts "On Ruby #{impl}"
    sh ". rvm #{impl}; rake run"
    results << [impl, "RAN"]
    puts
  end
  puts "=" * 40
  puts "Summary:"
  puts
  results.each do |impl, res|
    puts "#{impl} => RAN"
  end
  puts
  RubyImpls.expected.each do |requested_impl|
    impl_pattern = Regexp.new(Regexp.quote(requested_impl))
    puts "No Results for #{requested_impl}" unless results.detect { |x| x.first =~ impl_pattern }
  end
end
