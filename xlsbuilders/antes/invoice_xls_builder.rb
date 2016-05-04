class XlsBuilders::InvoiceXLSBuilder
  attr_reader :options

  def self.build(invoices_relation, options = {})
    new(invoices_relation, options).generate
  end

  def initialize(invoices_relation, options = {})
    @invoice_ids = invoices_relation.pluck(:id)
    @options = options
  end

  def generate
    package = Axlsx::Package.new
    @workbook = package.workbook
    @workbook.add_worksheet(name: "Invoice XLS") do |sheet|
      sheet.add_row header
      invoices_list.each do |invoice|
        sheet.add_row attributes_for(invoice), style: custom_style
      end
    end

    package.to_stream.read
  end

  def header
    [
      'ID',
      'Nome do cliente',
      'Status',
      'Data de criação',
      'Data de atualização',
      'Total em reais',
      'ID do usuário',
      'Peso excedente',
      'Peso total',
      'Camisas',
      'Camisas excedentes',
      'Preço das camisas excedentes em reais',
      'Preço de especiais em reais',
      'Preço do peso excedente em reais',
      'Data de vencimento',
      'Data de início',
      'Preço do plano em reais',
      'Fechada',
      'Contagem de especiais',
      'ID do plano',
      'Tipo do plano',
      'Desconto total por retrabalho em reais',
      'Desconto total de cupons em reais',
      'Cupons',
      'Status pagamento',
      'Status braspag',
      'Usuário com cobrança bloqueada',
      'Fatura com cobrança bloqueada',
      'Boleto',
      'Data de vencimento do boleto',
      'Observações'
    ]
  end

  def attributes_for(invoice)
    [
      invoice.id,
      invoice.user_name,
      invoice.friendly_status,
      invoice.created_at + invoice.created_at.utc_offset,
      invoice.updated_at + invoice.updated_at.utc_offset,
      parse_money(invoice.total_centavos),
      invoice.user_id,
      invoice.exceeding_weight,
      invoice.total_weight,
      invoice.social_tshirts_count,
      invoice.exceeding_social_tshirts,
      parse_money(invoice.exceeding_social_price_centavos),
      parse_money(invoice.special_price_centavos),
      parse_money(invoice.exceeding_weight_price_centavos),
      invoice.due_date,
      invoice.init_date,
      parse_money(invoice.plan_price_centavos),
      humanize_closed(invoice.closed),
      invoice.special_count,
      invoice.plan_id,
      invoice.plan.try(:frequency),
      parse_money(invoice.total_rework_discount_centavos),
      parse_money(invoice.total_coupon_discount_centavos),
      coupons_names(invoice),
      invoice.payment.try(:status),
      payment_error(invoice.payment),
      invoice.user.blocked_for_billing,
      invoice.blocked_for_billing,
      invoice.bank_slip_url,
      invoice.bank_slip_due_date,
      invoice.observation
    ]
  end

  def custom_style
    [
      nil,
      nil,
      nil,
      date_format,
      date_format,
      float_format,
      nil,
      nil,
      nil,
      nil,
      nil,
      float_format,
      float_format,
      float_format,
      nil,
      nil,
      float_format,
      nil,
      nil,
      nil,
      nil,
      float_format,
      float_format,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      date_format
    ]
  end

  private

  def parse_money(centavos)
    centavos / 100.0
  end

  def float_format
    return @float_format if @float_format.present?
    @float_format = @workbook.styles.add_style format_code: '0.00'
  end

  def date_format
    return @date_format if @date_format.present?
    @date_format = @workbook.styles.add_style format_code: 'dd/mm/yyyy hh:mm:ss'
  end

  def invoices_list
    Invoice.includes(:coupons => [], :payment => [:braspag_errors], :user => [], :orders => []).where(id: @invoice_ids)
  end

  def humanize_closed(state)
    if state
      "Sim"
    else
      "Não"
    end
  end

  def payment_error(payment)
    if payment and payment.error?
      payment.braspag_errors.last.try(:message).to_s
    else
      ""
    end
  end

  def coupons_names(invoice)
    invoice.coupons.map(&:name).join(' - ')
  end

end
