# encoding: utf-8

class XlsBuilders::CancellingReasonsXLSBuilder < XlsBuilders::Base
  sheet_title("Razões de Cancelamento")

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

  def line_style
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

end
