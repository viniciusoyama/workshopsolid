class XlsBuilders::Base
  attr_accessor :options, :scope

  class << self
    def sheet_title(value)
      @_sheet_title = value
    end

    def get_sheet_title
      raise "Please set a sheet title on #{self.class}" if @_sheet_title.nil?
      @_sheet_title
    end
  end

  def self.build(scope, options = {})
    new(scope, options).generate
  end

  def initialize(scope, options = {})
    @scope = scope
    @options = options
  end

  def generate
    package = Axlsx::Package.new
    @workbook = package.workbook
    @workbook.add_worksheet(name: self.class.get_sheet_title) do |sheet|
      sheet.add_row header
      items_scope.find_in_batches do |batch|
        batch.each do |resource|
          sheet.add_row attributes_for(resource), style: line_style
        end
      end
    end

    package.to_stream.read
  end

  def header
    raise 'You must implement header on child class'
  end

  def attributes_for(resource)
    raise 'You must implement attributes_for on child class'
  end

  def line_style
    raise 'You must implement line_style on child class'
  end

  def items_scope
    @scope
  end

  private
  def humanize_boolean(state)
    if state
      "Sim"
    else
      "Não"
    end
  end

  def float_format
    return @float_format if @float_format.present?
    @float_format = @workbook.styles.add_style format_code: '0.00'
  end

  def date_format
    return @date_format if @date_format.present?
    @date_format = @workbook.styles.add_style format_code: 'dd/mm/yyyy hh:mm:ss'
  end

end
