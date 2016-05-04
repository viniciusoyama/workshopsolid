class XlsBuilders::OperatorActivitiesXLSBuilder < XlsBuilders::Base
  sheet_title("Invoice XLS")

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

  def line_style
    [
      nil,
      nil,
      date_format,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil
    ]
  end

  private

  def date_format
    return @date_format if @date_format.present?
    @date_format = @workbook.styles.add_style format_code: 'dd/mm/yyyy hh:mm:ss'
  end

  def items_scope
    scope.includes(user: [], operator: [], order: [], order_item: [], bag:[])
  end
end
