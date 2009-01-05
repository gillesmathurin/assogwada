begin
  require 'fastercsv'
rescue Exception
  require 'csv'
end

module CSVExportable
  
  # Error Definitions
  class CSVExportableError < StandardError
  end
  
  # This Error is thrown during CSV Import if CSVExportable cannot determine how to import the file
  class UnknownImportTemplate < CSVExportableError
  end
  
  # This Error is thrown if the environment is missing a gem CSVExportable require to operate
  class MissingGem < CSVExportableError
  end
  
  # This Error is thrown when CSVExportable tries to set a column that does not exist on an object. 
  # Gives you a bit more context than the general method missing
  class InvalidColumn < CSVExportableError
  end
  
  
  module ActiveRecord
    module ClassMethods
      # Returns all instances of an ActiveRecord Class in CSV format
      #      Property.to_csv
      def to_csv(*args)
        find(:all).to_csv(*args)
      end
    end
    
    # == CSV Exporting
    # Allows for the easy exporting of ActiveRecord Models. The general design direction was to make thing both simple, yet flexible. 
    # 
    # The goal was to be able to export arbitrary columns of an ActiveRecord object, whether they were defined in the model or on a request. It was also a 
    # requirement that the columns headings could be named nicely, so that you could have a nice outer looking face to nasty column names, if you have that problem.
    # It was also important that column ordering are preserved (you can't rely on order for Hashes!)
    #
    # ==== Usage
    # - Call to_csv_export_columns in your model
    # - Call to_csv on an array of instances of your model and render to the browser to send as csv.
    # ==== Limitations
    # While currently you can use method chainings, none of the methods can take arguments. To get around this, you can create a function in your model that returns
    # the desired chaining.
    # ==== Example
    #     #proposal.rb
    #     class Proposal < ActiveRecord.rb
    #       to_csv_export_columns :default, [:id, :name, :description, :client_id, "client.name", :amount, :formatted_proposed_completion_date]
    #       to_csv_export_columns :detailed [:id, :name, :description, :client_id, "client.name", :projected_cost, :amount, :projected_profit, :formatted_proposed_completion_date]
    #      
    #       # since we can't use arguments, we define a method
    #       def formatted_proposed_completion_date
    #         self.proposed_completion_date.strftime("%Y %M %d")
    #       end
    #
    #       def projected_profit
    #         self.amount - self.projected_cost
    #       end
    #     end
    # 
    #    #controller
    #    def show
    #      @proposal = Proposal.find(params[:id])
    #      export_format = (current_user.is_admin? ? :detailed : :default)
    #      
    #      respond_to do |format|
    #        format.csv { render :text => @proposal.to_csv(export_format) }
    #       end
    #    end
    #
    module ExportColumns
      def self.included(base)#:nodoc:
        base.extend(ClassMethods)
        base.class_eval { include InstanceMethods }
      end
  
      module ClassMethods      
        @@export_columns = {}
        # Call this method in the model of which you would like to override default export functionality. The default export is all content columns 
        # except for updated_at and created_at.
        # 
        #     #proposal.rb
        #     class Proposal < ActiveRecord::Base
        #       to_csv_export_columns :default, [:id, :name, :description, :client_id, "client.name", :amount, :formatted_proposed_completion_date]
        #       to_csv_export_columns :detailed [:id, :name, :description, :client_id, "client.name", :projected_cost, :amount, :projected_profit, :formatted_proposed_completion_date]
        #     end
        # You can define an unlimited number of export templates.
        # ==== Specifying Columns
        # You can specify columns in one of two ways. In both cases, columns is an array. 
        # * Pass in an array of string or symbols. This will use the string/symbol as both the column header and the method that will populate that column
        # * Pass in an array of hashes. Each hash has one key-value pair. The key will be used as the column header, the value will be the method called to populate the column.
        # 
        #   # pass in a simple array of string and symbols
        #   to_csv_export_columns :simple, [:id, :name, "client.name", :some_really_long_verbose_column_name]
        #    
        #   # or pass in an array of hashes
        #   to_csv_export_columns :advanced, [{:project_id => :id}, {:project_name => :name}, {:client => "client.name"}, {:short_name => :some_really_long_verbose_column_name}]
        #         
        def to_csv_export_columns(template, columns)
          @@export_columns[self.to_s] ||= {}
          @@export_columns[self.to_s][template.to_sym] ||= {}
          add_to_export_columns(template, columns)
        end
        
        def add_to_export_columns(template, columns)#:nodoc:
          @@export_columns[self.to_s][template.to_sym] = columns
        end
        
        # Used to create the header row of the csv file and determine what method calls are needed to fill in csv data.
        #
        def get_export_columns(template = :default)
          # if nil is passed in
          template ||= :default
          if all_export_columns.keys.include?(template.to_sym)
            all_export_columns[template.to_sym]
          elsif template == :default
            content_columns.map(&:name) - ['created_at', 'update_at']
          else
            {}
          end
        end
        def all_export_columns#:nodoc:
          @@export_columns[self.to_s] || {}
        end

      end
      
      module InstanceMethods
        # This returns an array of data that is used by to_csv to construct the lines of a csv data file.
        #
        def to_row(template = :default, columns = [])
          columns_to_export = columns.blank? ? self.class.get_export_columns(template) : columns
          
          columns_to_export.map do |element|
            if element.is_a? String or element.is_a? Symbol
               csv_get_value_of_method(element)
            elsif element.is_a? Hash
               val = element.values.first
                if val.is_a? String or val.is_a? Symbol
                  csv_get_value_of_method(val)
                else
                  ""
                end
            else
              ""
            end
          end # end columns_to_export.map
        end # end to_row

        private
        def csv_get_value_of_method(method)#:nodoc:
          parts = method.to_s.split('.')
          # if it is a single method call, go ahead and make it
          if parts.size == 1
            self.send(method)
          else
            # otherwise, it is a chained method call, we have to loop through the sends
            response = self
            parts.each do |part|
              # the if statement is to trap a nil.something call. NilClass won't respond to 'something', so it will get translated to a "" in the CSV. No worries
              response = response.send(part) if response.respond_to?(part)
            end
            response
          end
        end        
      end
    end    
    
    # == CSV Importing
    # This is used to allow bulk importing of objects through CSV
    # ==== Requirements
    # - FasterCSV gem is required for this part of CSV Exportable to function
    # ==== Usage
    # - The first step is to get a template csv file using import_template
    # - Once this template file is populated, it is uploaded and handed off to a model that you wish to batch import using from_csv
    # - You are returned a collection of unsaved objects
    # ==== Example
    #    @template = Proposal.import_template(:detailed)
    #    #... template is filled out and uploaded through a form
    #
    #    #controller...
    #    file = params[:file]
    #    @proposals = Proposal.from_csv(file)
    #    if @proposals.all?(&:valid?)
    #      @proposals.each {|p| p.save }
    #    else
    #      flash[:error] = "There was at least one error importing your Proposals"
    #    end
    #
    module ImportColumns
      def self.included(base)#:nodoc:
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        @@import_columns = {}                   
        # Call this method in your model with which you wish to do batch importing
        #   class Proposal < ActiveRecord::Base
        #     from_csv_import_columns :default, [:name, :description, :client_id, :project_id, :amount] 
        #     from_csv_import_columns :fancy, [{:name => :first_name}, {:tags => :new_tags }]
        #  
        #     def new_tags=(string_of_tags)
        #       self.tags= string_of_tags.split(/,/)
        #     end
        #  end
        #
        # You can define as many as you like, giving them unique names
        # Note that if you are defining custom functions (like +new_tags+ above), you must name them with an "=" at the end
        #
        def from_csv_import_columns(template, columns)
          @@import_columns[self.to_s] ||= {}
          @@import_columns[self.to_s][template.to_sym] ||= {}
          add_to_import_columns(template, columns)
        end

        def add_to_import_columns(template, columns)#:nodoc:
          @@import_columns[self.to_s][template.to_sym] = columns
        end

        def get_import_columns(template = :default)#:nodoc:
          # if nil is passed in
          template ||= :default
          if all_import_columns.keys.include?(template.to_sym)
            all_import_columns[template.to_sym]
          elsif template == :default
            content_columns.map(&:name).sort - ['created_at', 'update_at']
          else
            {}
          end
        end

        def all_import_columns#:nodoc:
          @@import_columns[self.to_s] || {}
        end
        
        # Get a csv template for the import type. This will return CSV data for how the importing csv file should be structured. It is assumed that the user actually uses
        # this file when submitting their import csv, with the row of column headings intact. 
        #    #controller...
        #    def download_template
        #      type = params[:format]
        #      respond_to do |format|
        #        format.csv { render :text => Proposal.import_template(type) }
        #      end
        #
        def import_template(template = :default)
          columns = get_import_columns(template)
          header_row = column_definitions_to_header_row(columns)
          header_row.to_csv
        end
        
        def column_definitions_to_header_row(columns)#:nodoc:
          header_row = columns.map do |col|        
            if col.is_a? String or col.is_a? Symbol
              col
            elsif col.is_a? Hash
              col.keys.first
            end
          end
          header_row.map! { |c| c.to_s.gsub('_', ' ').titleize }
        end
        
        # Use this to batch import an object from a csv file. You can specify which import formatting is used, these are defined using the from_csv_import_columns method.
        # CSV Template files are available using import_template. 
        #
        # If a type is not passed in, from_csv will try to determine which template to use from the columns on the csv. If none match, i
        # ==== Assumptions 
        # - FasterCSV gem is available
        # ==== Example
        #    #controller...
        #    file = params[:file]
        #    @proposals = Proposal.from_csv(file)
        #    if @proposals.all?(&:valid?)
        #      @proposals.each {|p| p.save }
        #    else
        #      flash[:error] = "There was at least one error importing your Proposals"
        #    end
        #
        def from_csv(csv_file, template=nil)
          unless defined? FasterCSV
            raise CSVExportable::MissingGem("CSV Importing requires the FasterCSV gem to operate")
          end
          count = 0
          columns = flatten_import_columns(get_import_columns(template)) unless template.blank?                  
                      
          objects = []
          FasterCSV.parse(csv_file.read) do |row|
            if count > 0 #skip the first row (column headings)
              objects << from_csv_row(columns, row)
            else
              columns ||= find_columns_hash_from_column_names(row)
            end
            count +=1       
          end
          return objects
        end 
        

        def flatten_import_columns(arr)
          flattened = []
          arr.each do |hash_or_string|
            if hash_or_string.is_a? Hash
              flattened << hash_or_string.values.first.to_s
            elsif hash_or_string.is_a? String
              flattened << hash_or_string
            end              
          end
          return flattened
        end
        
        # Throws a CSVExportable::UnknownImportTemplate Exception if the column names don't match a defined template. This method is only called if a template is not passed in from_csv
        #
        def find_columns_hash_from_column_names(column_names)
          all_import_columns.each do |template_name,c|
            if column_definitions_to_header_row(c) == column_names
              return flatten_import_columns(c)
            end
          end   
          
          o = self.new
          columnized_names = column_names.map { |c| c.to_s.titleize.gsub(/ /, '').underscore }
          columnized_names.each do |c|
            unless o.respond_to?("#{c}=")
            raise CSVExportable::UnknownImportTemplate.new("Could Not Determine How To Import CSV File")
          end
          
          return columnized_names
          
        end
        
        # Used to create an instance of an object from a CSV row
        # 
        # +columns+ is used to know which attributes you are trying to set
        # +row+ is an array of the csv data
        #
        def from_csv_row(columns, row)
          row.each { |c| c.strip! unless c.nil? }
          count = 0
               
          #columns here should always be an array of strings (method_names), no hashes            
          placement = 0
          if columns.include?(self.primary_key.to_s)
            columns.each_with_index do |method, i|
              if method.to_s == self.primary_key.to_s
                placement = i
                break
              end
            end
          end
            
          new_object = self.find(row[placement]) if self.exists?(row[placement])           
          new_object ||= new        

          columns.each do |attribute|
            unless new_object.respond_to?(attribute.to_s + "=")
              raise CSVExportable::InvalidColumn.new("Object does not respond to #{attribute.values.first}=")
              next
            end
              new_object.send(attribute.to_s + "=", row[count])
            end
            count += 1
          end
          new_object
        end
      end
    end
  end  
end

#--
# We need to define this method like this, rather than through modules to overwrite the to_csv method that FasterCSV implements on Array.    
#++
class Array
  # Takes an array of ActiveRecord objects and translates them into an array by calling to_row on them. After which it calls to_csv on the resulting array, turning it into a line of CSV.
  #   @properties = Property.find(:all)
  #   @properties.to_csv(:template => :fancy)
  #   #=> Displays the CSV with columns as determined in export_columns, given a :fancy template.
  #   @properties.to_csv(:columns => {:property_owner => "owner.name", :address => "address"})
  #   #=> "Property Owner, Address\nPeter Leonhardt,\"2391 N Bild St Minneapolis, MN\"\nJoe Schmoe, 123 Fake St\n"
  # ==== Options
  # - <tt>:template</tt>: This allows you to be able to specify presets of columns to use (defined in the model). Defaults to :default
  # - <tt>:columns</tt>: This allows you to be able to pass in an array (or hash) of columns to uses
  # ===== Note
  # If <tt>:columns</tt> is specified, it will take precendence over :template
  # 
  def to_csv(options = {})
    return "" if self.empty?
    if all? { |e| e.respond_to?(:to_row) }
      columns = options.delete(:columns) || (options[:template].blank? ? first.class.get_export_columns(:default) : first.class.get_export_columns(options[:template]))
      column_names = columns.map do |c|
       if c.is_a? String or c.is_a? Symbol
         c.to_s
       else
         c.keys.first.to_s
       end        
      end
      methods = columns.map do |c|
        if c.is_a? String or c.is_a? Symbol
          c.to_s
        else
          c.values.first.to_s
        end
      end
      
      header_row = column_names.map { |c| c.to_s.gsub('_', ' ').titleize }.to_csv #if .titleize is called without the gsub, unit_id will turn into Unit, not desired, we want Unit Id
      content_rows = map { |e| e.to_row(options[:template], methods) }.map(&:to_csv)       
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

# lazy loading plugin.. just add the macro functions
## sort of lazy loading. Model.to_csv is there, as well as .to_csv on Array
ActiveRecord::Base.class_eval do
  # Add the AnyClass.to_csv method
  extend CSVExportable::ActiveRecord::ClassMethods
  # Add to_csv_export_columns
  include CSVExportable::ActiveRecord::ExportColumns
  # Add from_csv_export_columns
  include CSVExportable::ActiveRecord::ImportColumns
end