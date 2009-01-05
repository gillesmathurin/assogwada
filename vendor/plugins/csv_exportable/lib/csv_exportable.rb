# ==============================+++===============================#
#                         CSV Exportable
# ==============================+++===============================#
# # Created by Peter Leonhardt
# # Thanks to Bryan Helmkamp, whose code got me started
# # Created On:  2008-02-14
# ================================================================#
# # This Plugin is licensed under the MIT License
# ================================================================#
begin
  require 'fastercsv'
rescue Exception
  require 'csv'
end

module CSVExportable#:nodoc:
  module ActiveRecord
    module ClassMethods
      # Returns all instances of an ActiveRecord Class in CSV format
      #      Property.to_csv(:columns => ["address", "street", "city"])
      def to_csv(*args)
        find(:all).to_csv(*args)
      end
    end
    
    module InstanceMethods
      # Override this method in the classes you want to export if you don't want the default of all content columns.
      #   def export_columns(format = nil)
      #     case format
      #     when :detailed
      #       ["first_name", "last_name", "email_address", "mailing_address"]
      #     else
      #       ["first_name", "last_name"]
      #    end
      #  end
      def export_columns(format = nil)
        self.class.content_columns.map(&:name) - ['created_at', 'updated_at']
      end

      # This turns an Active Record instance into an array of attributes
      #     @user = User.new(:first_name => "Peter", :last_name => "Leonhardt", :favorite_language => "ruby")
      #     @user.to_row
      #     #=> ["Peter", "Leonhardt", "ruby"]
      def to_row(format = nil, columns = [])
        columns_to_export = columns.blank? ? export_columns(format) : columns
        
        columns_to_export.map do |c|
          parts = c.split('.')
          if parts.size == 1
            self.send(c)
          else
            # a column that works through associations...
            # "person.first_name" => self.send(:person).send(:first_name)
            response = self
            parts.each do |p|
              # this will take care of calling nil.somethin, NilClass won't respond to 'something', so it will get translated to a "" in the CSV
              response = response.send(p) if response.respond_to?(p)
            end
            response
          end                
        end
      end
    end
  end
end
      
ActiveRecord::Base.class_eval do
  extend CSVExportable::ActiveRecord::ClassMethods
  include CSVExportable::ActiveRecord::InstanceMethods
end

#--
# We need to define this method like this, rather than through modules to overwrite the to_csv method that FasterCSV implements on Array.    
#++
class Array
  # Takes an array of ActiveRecord objects and translates them into an array by calling to_row on them. After which it calls to_csv on the resulting array, turning it into a line of CSV.
  #   @properties = Property.find(:all, :limit => 2)
  #   @properties.to_csv(:format => :short)
  #   #=> Displays the CSV with columns as determined in export_columns, given a :short format.
  #   @properties.to_csv(:columns => {:property_owner => "owner.name", :address => "address"})
  #   #=> "Property Owner, Address\nPeter Leonhardt,\"2391 N Bild St Minneapolis, MN\"\nJoe Schmoe, 123 Fake St\n"
  # ==== Options
  # - <tt>:format</tt>: This allows you to be able to specify presets of columns to use (defined in the model)
  # - <tt>:columns</tt>: This allows you to be able to pass in an array (or hash) of columns to uses
  #
  def to_csv(options = {})
    return "" if self.empty?
    if all? { |e| e.respond_to?(:to_row) }
      columns = options.delete(:columns) || first.export_columns(options[:format])
      column_names = columns.is_a?(Hash) ? columns.keys : columns
      methods = columns.is_a?(Hash) ? columns.values : columns      
      
      header_row = column_names.map { |c| c.to_s.titleize }.to_csv
      content_rows = map { |e| e.to_row(options[:format], methods) }.map(&:to_csv)       
      ([header_row] + content_rows).join
    else 
      if defined? FasterCSV
        FasterCSV.generate_line(self)
      else
        buffer = ''
        CSV.generate_row(self, self.size, buffer)
        buffer
      end
    end
  end
end
      
# add the csv MimeType
Mime::Type.register 'text/csv', :csv, %w('text/comma-separated-values')

