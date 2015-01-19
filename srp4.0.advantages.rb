
before(:each) do
  @payment = FactoryGirl.create(:payment)
  @order = @payment.order
  stub_const("Order::PriceCalculator", Class.new do
    def initialize(order)
      @order = order
    end

    def net
      100.to_money
    end

    def gross
      100.to_money
    end
  end)
end

describe 'Requests' do
  describe 'POST process_moip_response' do
    context 'payment was finished' do
      before(:each) do
        @params = {
          id_transacao: @payment.id,
          status_pagamento: 4
        }
      end

      it 'updates the payment status' do
        post :process_moip_response, @params
        @payment.reload.status.should == Public::MoipNaspController::PAYMENT_STATUSES[@params[:status_pagamento]]
      end
    end
  end
end
