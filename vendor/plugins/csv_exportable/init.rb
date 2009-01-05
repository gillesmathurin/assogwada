# require here, so plugin is loaded in the app automatically
#require 'csv'
require 'macro_exportable'
# add the csv MimeType
Mime::Type.register 'text/csv', :csv, %w('text/comma-separated-values')