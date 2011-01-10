require "raylayers/version"

module Raylayers
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc "This generator downloads and installs OpenLayers"
      class_option :version, :type => :string, :default => Raylayers::VERSION, :desc => "Which version of OpenLayers to fetch"
      
      def download_openlayers
        say_status("fetching", "OpenLayers (#{options.version})", :green)
        get "http://openlayers.org/download/OpenLayers-#{options.version}.tar.gz"
      rescue OpenURI::HTTPError
        say_status("error", "could not find OpenLayers (#{options.version})", :yellow)
      end
    end
  end
end
