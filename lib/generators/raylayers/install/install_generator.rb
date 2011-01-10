require 'zip/zip'
require 'fileutils'

module Raylayers
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc "This generator downloads and installs OpenLayers"
      class_option :version, :type => :string, :default => '2.10', :desc => "Which version of OpenLayers to fetch"

      def download_openlayers
        @tmp_file = "tmp/OpenLayers-#{options.version}.zip"
        say_status("fetching", "OpenLayers (#{options.version})", :green)
        get "http://openlayers.org/download/OpenLayers-#{options.version}.zip",  @tmp_file
      rescue OpenURI::HTTPError
        say_status("error", "could not find OpenLayers ({options.version})", :red)
      end
      
      def unpack_openlayers
        say_status("unpacking", @tmp_file, :green)
        Zip::ZipFile.open(@tmp_file) do |zip|
          zip.each do |file|
            file_path = File.join("tmp/", file.to_s)
            directory = file_path[0, file_path.rindex("/") + 1] 
            FileUtils.mkdir_p(directory) unless File.directory?(directory)
            zip.extract(file, file_path) unless File.exists? file_path
          end
        end
      rescue
        say_status("error", "could not unpack #{@tmp_file}", :red)
      end
      
      def build_openlayers
        say_status("building", "OpenLayers (#{options.version})", :green)
        # TODO: ruby script?
        Dir.chdir("tmp/OpenLayers-#{options.version}/build"){ system("python build.py 1> /dev/null")}
      rescue
        say_status("error", "could not build OpenLayers", :red)
      end
      
      def install_openlayers
        say_status("installing", "OpenLayers (#{options.version})", :green)
        FileUtils.mkdir_p("public/openlayers/")
        FileUtils.cp("tmp/OpenLayers-#{options.version}/build/OpenLayers.js", "public/openlayers/OpenLayers.js")
        FileUtils.cp_r("tmp/OpenLayers-#{options.version}/theme", "public/openlayers/theme")
        FileUtils.cp_r("tmp/OpenLayers-#{options.version}/img", "public/openlayers/img")
      rescue
        say_status("error", "could not install OpenLayers", :red)
      end
      
      def remove_tmp_files
        say_status("clean", "Removing temp files", :green)
        FileUtils.rm_f(@tmp_file)
        FileUtils.rm_rf("tmp/OpenLayers-#{options.version}")
      end
    end
  end
end
