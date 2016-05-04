class XlsBuilders::OperatorActivitiesXLSBuilder
  attr_reader :options

  def self.build(activities_relation, options = {})
    new(activities_relation, options).generate
  end

  def initialize(activities_relation, options = {})
    @activity_ids = activities_relation.pluck(:id)
    @options = options
  end

  def generate
    package = Axlsx::Package.new
    @workbook = package.workbook
    @workbook.add_worksheet(name: "Atividade de operadores XLS") do |sheet|
      sheet.add_row header

      activities_list.each do |activity|
        sheet.add_row attributes_for(OperatorActivityDecorator.decorate(activity)), style: custom_style
      end

    end

    package.to_stream.read
  end

  def header
    [
      'Operador',
      'Posto',
      'Data',
      'Sacola',
      'Peça',
      'Lote',
      'Pedido',
      'Sucesso?',
      'Resposta'
    ]
  end

  def attributes_for(activity)
    [
      activity.operator,
      activity.type,
      activity.created_at + activity.created_at.utc_offset,
      activity.bag.try(:number),
      activity.garment.try(:code),
      activity.lot_code,
      activity.order_id,
      activity.success?,
      activity.response
    ]
  end

  def custom_style
    [
      nil,
      nil,
      date_format,
      nil
    ]
  end

  private

  def date_format
    return @date_format if @date_format.present?
    @date_format = @workbook.styles.add_style format_code: 'dd/mm/yyyy hh:mm:ss'
  end

  def activities_list
    Logs::OperatorActivity::Base.includes(user: [], operator: [], order: [], garment: [], order_item: [], bag:[], delivery_lot: []).where(id: @activity_ids)
  end
end
