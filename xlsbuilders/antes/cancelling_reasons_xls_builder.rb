class XlsBuilders::CancellingReasonsXLSBuilder
  attr_accessor :options

  def self.build(cancelling_reasons, options = {})
    new(cancelling_reasons, options).generate
  end

  def initialize(cancelling_reasons, options = {})
    @cancelling_reasons = cancelling_reasons
    @options = options
  end

  def generate
    package = Axlsx::Package.new
    @workbook = package.workbook
    @workbook.add_worksheet(name: "Order Item XLS") do |sheet|
      sheet.add_row header
      @cancelling_reasons.each do |cancelling_reason|
        sheet.add_row attributes_for(cancelling_reason), style: custom_style
      end
    end

    package.to_stream.read
  end

  def header
    [
      'Id do usuario',
      'Nome',
      'Motivo',
      'E-mail',
      'Telefone',
      'Rota',
      'Plano',
      'Frequencia',
      'Tipo',
      'Peso(g)',
      'Preco do plano',
      'Data de cricacao do plano',
      'Data de atualizacao do plano',
      'Data de cancelamento'
    ]
  end

  def attributes_for(cancelling_reason)
    [
      cancelling_reason.user.try(:id),
      cancelling_reason.user.try(:name),
      cancelling_reason.reason.to_s,
      cancelling_reason.user.try(:email),
      cancelling_reason.user.try(:phone),
      cancelling_reason.user.try(:available_cep).try(:trajectory),
      cancelling_reason.plan.name,
      cancelling_reason.plan.frequency,
      cancelling_reason.plan.type,
      cancelling_reason.plan.weight,
      cancelling_reason.plan.price,
      cancelling_reason.plan.created_at + cancelling_reason.plan.created_at.utc_offset,
      cancelling_reason.plan.updated_at + cancelling_reason.plan.updated_at.utc_offset,
      cancelling_reason.created_at + cancelling_reason.created_at.utc_offset
    ]
  end

  def custom_style
    [
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      date_format,
      date_format,
      date_format
    ]
  end

  private

  def date_format
    return @date_format if @date_format.present?
    @date_format = @workbook.styles.add_style format_code: 'dd/mm/yyyy hh:mm:ss'
  end

end
