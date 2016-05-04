class XlsBuilders::InvoiceXLSBuilder < XlsBuilders::Base
  sheet_title("Invoice XLS")

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
      invoice.total_centavos.to_f,
      invoice.user_id,
      invoice.exceeding_weight,
      invoice.total_weight,
      invoice.social_tshirts_count,
      invoice.exceeding_social_tshirts,
      invoice.exceeding_social_price_centavos.to_f,
      invoice.special_price_centavos.to_f,
      invoice.exceeding_weight_price_centavos.to_f,
      invoice.due_date,
      invoice.init_date,
      invoice.plan_price_centavos.to_f,
      humanize_boolean(invoice.closed),
      invoice.special_count,
      invoice.plan_id,
      invoice.plan.try(:frequency),
      invoice.total_rework_discount_centavos.to_f,
      invoice.total_coupon_discount_centavos.to_f,
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

  def line_style
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

  def items_scope
    scope.includes(:coupons => [], :payment => [:braspag_errors], :user => [], :orders => [])
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
