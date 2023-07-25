# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Contactpay::Invoice do
  before do
    Contactpay.configure do |config|
      config.base_url = 'https://api-test.contactpay.io'
      config.account_secret_key = '731a577aa3084fe6ac76cdbe3be0629b'
      config.shop_id = 356
    end

    Timecop.freeze(Time.parse('2023-07-18T13:23:41'))
  end

  let(:invoice) { described_class.new }

  describe '#payment_methods' do
    subject(:result) { invoice.payment_methods }

    context 'when request_data is valid', vcr: 'invoice/payment_methods' do
      let(:response) do
        {
          'data' => [
            {
              'id' => 1,
              'name' => 'Test pay method',
              'payways' => [
                {

                  'add_ons_config' => nil,
                  'alias' => 'card_core_payin_rub[mock_server,internal_server_error]',
                  'currency' => 643,
                  'fee_config' => { 'fix' => 0.0, 'percent' => 5.0 },
                  'fee_part_config' => { 'fix_part' => 1, 'percent_part' => '1.0' },
                  'id' => 90, 'is_active' => true, 'max_amount' => 100_000.0, 'min_amount' => 5.0
                },
                {
                  'add_ons_config' => nil,
                  'alias' => 'card_core_payin_rub[mock_server,create_declined_with_callback]',
                  'currency' => 643,
                  'fee_config' => { 'fix' => 0.0, 'percent' => 5.0 },
                  'fee_part_config' => { 'fix_part' => 1, 'percent_part' => '1.0' },
                  'id' => 88, 'is_active' => true, 'max_amount' => 100_000.0, 'min_amount' => 5.0
                },
                {
                  'add_ons_config' => {},
                  'alias' => 'card_core_payin_rub[mock_server,success_with_callback]',
                  'currency' => 643,
                  'fee_config' => {
                    'fix' => 0.0, 'percent' => 5.0
                  },
                  'fee_part_config' => { 'fix_part' => 1, 'percent_part' => '1.0' },
                  'id' => 93, 'is_active' => true, 'max_amount' => 100_000.0, 'min_amount' => 5.0
                },
                {
                  'add_ons_config' => nil,
                  'alias' => 'card_core_payin_rub[mock_server,timeout_error]',
                  'currency' => 643,
                  'fee_config' => { 'fix' => 0.0, 'percent' => 5.0 },
                  'fee_part_config' => { 'fix_part' => 1, 'percent_part' => '1.0' },
                  'id' => 89, 'is_active' => true, 'max_amount' => 100_000.0, 'min_amount' => 5.0
                }
              ],
              'rating' => 1
            },
            {
              'id' => 2,
              'name' => 'QIWI Кошелек',
              'payways' => [
                {
                  'add_ons_config' => {
                    'phone' => {
                      'comment' => {
                        'en' => 'Enter your phone number in international format without «+»',
                        'ru' => 'Введите номер телефона в международном формате, без «+»'
                      },
                      'example' => '79133456789',
                      'label' => { 'en' => 'Qiwi-wallet number:', 'ru' => 'Номер Qiwi-кошелька:' },
                      'prefix' => '+',
                      'regex' => '^(91|994|82|372|375|374|44|998|972|66|90|81|1|507|7' \
                        '|77|380|371|370|996|9955|992|373|84)[0-9]{6,14}$'
                    }
                  },
                  'alias' => 'qiwi_wallet_rub[mock_server,success]',
                  'currency' => 643,
                  'fee_config' => { 'fix' => 0.0, 'percent' => 5.0 },
                  'fee_part_config' => { 'fix_part' => 1, 'percent_part' => '1.0' },
                  'id' => 1, 'is_active' => true, 'max_amount' => 100_000.0, 'min_amount' => 5.0
                },
                {
                  'add_ons_config' => {
                    'phone' => {
                      'comment' => {
                        'en' => 'Enter your phone number in international format without «+»',
                        'ru' => 'Введите номер телефона в международном формате, без «+»'
                      },
                      'example' => '79133456789',
                      'label' => { 'en' => 'Qiwi-wallet number:', 'ru' => 'Номер Qiwi-кошелька:' },
                      'prefix' => '+',
                      'regex' => '^(91|994|82|372|375|374|44|998|972|66|90|81|1|507|7' \
                        '|77|380|371|370|996|9955|992|373|84)[0-9]{6,14}$'
                    }
                  },
                  'alias' => 'qiwi_wallet_rub[mock_server,rejected_with_callback]',
                  'currency' => 643,
                  'fee_config' => { 'fix' => 0.0, 'percent' => 5.0 },
                  'fee_part_config' => { 'fix_part' => 1, 'percent_part' => '1.0' },
                  'id' => 34, 'is_active' => true, 'max_amount' => 100_000.0, 'min_amount' => 5.0
                },
                {
                  'add_ons_config' => { 'phone' => {
                    'comment' => {
                      'en' => 'Enter phone number in international format. List of supported country codes: ' \
                        '91, 994, 82, 372, 375, 374, 44, 998, 972, 66, 90, 507, 7' \
                        ', 77, 380, 371, 370, 996, 9955, 992, 373, 84',
                      'ru' => 'Введите номер телефона в международном формате. Поддерживаемые коды стран: ' \
                        '91, 994, 82, 372, 375, 374, 44, 998, 972, 66, 90, 507,' \
                        ' 7, 77, 380, 371, 370, 996, 9955, 992, 373, 84'
                    },
                    'example' => '79133456789',
                    'label' => {
                      'en' => 'Qiwi-wallet number:', 'ru' => 'Номер Qiwi-кошелька:'
                    },
                    'prefix' => '+',
                    'regex' => '^(91|994|82|372|375|374|44|998|972|66|90|507|7' \
                      '|77|380|371|370|996|9955|992|373|84)[0-9]{6,14}$'
                  } },
                  'alias' => 'qiwi_wallet_rub[mock_server,success_with_callback]',
                  'currency' => 643,
                  'fee_config' => { 'fix' => 0.0, 'percent' => 5.0 },
                  'fee_part_config' => { 'fix_part' => 1, 'percent_part' => '1.0' },
                  'id' => 18, 'is_active' => true, 'max_amount' => 100_000.0, 'min_amount' => 5.0
                },
                {
                  'add_ons_config' => {},
                  'alias' => 'token_qiwi_wallet_rub[mock_server,success_with_callback]',
                  'currency' => 643,
                  'fee_config' => {
                    'fix' => 0.0, 'percent' => 2.2
                  },
                  'fee_part_config' => { 'fix_part' => 1, 'percent_part' => '1.0' },
                  'id' => 190, 'is_active' => true, 'max_amount' => 100_000.0, 'min_amount' => 5.0
                },
                {
                  'add_ons_config' => { 'phone' => {
                    'comment' => {
                      'en' => 'Enter your phone number in international format without «+»',
                      'ru' => 'Введите номер телефона в международном формате, без «+»'
                    },
                    'example' => '79133456789',
                    'label' => { 'en' => 'Qiwi-wallet number:', 'ru' => 'Номер Qiwi-кошелька:' },
                    'prefix' => '+',
                    'regex' => '^(91|994|82|372|375|374|44|998|972|66|90|81|1' \
                      '|507|7|77|380|371|370|996|9955|992|373|84)[0-9]{6,14}$'
                  } },
                  'alias' => 'qiwi_wallet_rub[mock_server,rejected]',
                  'currency' => 643,
                  'fee_config' => { 'fix' => 0.0, 'percent' => 5.0 },
                  'fee_part_config' => { 'fix_part' => 1, 'percent_part' => '1.0' },
                  'id' => 4, 'is_active' => true, 'max_amount' => 100_000.0, 'min_amount' => 5.0
                },
                {
                  'add_ons_config' => { 'phone' => {
                    'comment' => {
                      'en' => 'Enter your phone number in international format without «+»',
                      'ru' => 'Введите номер телефона в международном формате, без «+»'
                    },
                    'example' => '79133456789',
                    'label' => { 'en' => 'Qiwi-wallet number:', 'ru' => 'Номер Qiwi-кошелька:' },
                    'prefix' => '+',
                    'regex' => '^(91|994|82|372|375|374|44|998|972|66|90|81|1' \
                      '|507|7|77|380|371|370|996|9955|992|373|84)[0-9]{6,14}$'
                  } },
                  'alias' => 'qiwi_wallet_rub[mock_server,internal_server_error]',
                  'currency' => 643,
                  'fee_config' => { 'fix' => 0.0, 'percent' => 5.0 },
                  'fee_part_config' => { 'fix_part' => 1, 'percent_part' => '1.0' },
                  'id' => 2, 'is_active' => true, 'max_amount' => 100_000.0, 'min_amount' => 5.0
                },
                {
                  'add_ons_config' => { 'phone' => {
                    'comment' => {
                      'en' => 'Enter your phone number in international format without «+»',
                      'ru' => 'Введите номер телефона в международном формате, без «+»'
                    },
                    'example' => '79133456789',
                    'label' => { 'en' => 'Qiwi-wallet number:', 'ru' => 'Номер Qiwi-кошелька:' },
                    'prefix' => '+',
                    'regex' => '^(91|994|82|372|375|374|44|998|972|66|90|81|1' \
                      '|507|7|77|380|371|370|996|9955|992|373|84)[0-9]{6,14}$'
                  } },
                  'alias' => 'qiwi_wallet_rub[mock_server,timeout_error]',
                  'currency' => 643,
                  'fee_config' => { 'fix' => 0.0, 'percent' => 5.0 },
                  'fee_part_config' => { 'fix_part' => 1, 'percent_part' => '1.0' },
                  'id' => 3, 'is_active' => true, 'max_amount' => 100_000.0, 'min_amount' => 5.0
                }
              ], 'rating' => 2
            }
          ],
          'error_code' => 0,
          'message' => 'Ok',
          'result' => true
        }
      end

      it 'returns request data' do
        expect(result).to eql(response)
      end
    end
  end

  describe '#prelim_calc' do
    subject(:result) { invoice.prelim_calc(request_data) }

    context 'when request_data is valid', vcr: 'invoice/prelim_calc' do
      let(:request_data) do
        {
          'shop_order_id' => '117',
          'amount' => '299.45',
          'currency' => 840,
          'payway' => 'card_core_payin_rub[mock_server,success_with_callback]',
          'description' => 'Testing invoices'
        }
      end

      let(:response) do
        {
          'data' => {
            'add_ons_config' => {},
            'info' => {},
            'manual' => {
              'en' => 'text',
              'ru' => 'текст'
            },
            'payer_price' => 27_051.71,
            'paymethod_id' => 1,
            'paymethod_name' => 'Test pay method',
            'ps_currency' => 643,
            'warning' => {}
          },
          'error_code' => 0,
          'message' => 'Ok',
          'result' => true
        }
      end

      it 'returns request data' do
        expect(result).to eql(response)
      end
    end
  end

  describe '#create' do
    subject(:result) { invoice.create(request_data) }

    context 'when request_data is valid', vcr: 'invoice/create' do
      let(:request_data) do
        {
          'shop_order_id' => '117',
          'amount' => '299.45',
          'currency' => 643,
          'payway' => 'card_core_payin_rub[mock_server,success_with_callback]',
          'description' => 'Testing invoices'
        }
      end

      let(:response) do
        {
          'data' => {
            'data' => {
              'session_id' => '453c7fbe448a41b591d937bd02fff4ba'
            },
            'id' => 33_733_463,
            'method' => 'GET',
            'url' => 'https://checkout-test.contactpay.io/pay/453c7fbe448a41b591d937bd02fff4ba'
          },
          'error_code' => 0,
          'message' => 'Ok',
          'result' => true
        }
      end

      it 'returns request data' do
        expect(result).to eql(response)
      end
    end
  end

  describe '#status' do
    subject(:result) { invoice.status(request_data) }

    context 'when request_data is valid', vcr: 'invoice/status' do
      let(:request_data) do
        {
          'shop_order_id' => '117'
        }
      end

      let(:response) do
        {
          'data' => { 'client_price' => 299.45,
                      'created' => '2023-07-25T13:48:42',
                      'description' => 'Testing invoices',
                      'error_code' => 0,
                      'is_unique' => true,
                      'payment_id' => 33_733_463,
                      'payway' => 'card_core_payin_rub[mock_server,success_with_callback]',
                      'processed' => '2023-07-25T14:10:34',
                      'ps_currency' => 643,
                      'ps_data' => '{"ps_payer_account": "424242XXXXXX4242", "required_3ds": false}',
                      'shop_amount' => 299.45,
                      'shop_currency' => 643,
                      'shop_id' => 356,
                      'shop_order_id' => '117',
                      'shop_refund' => 284.48,
                      'status' => 4,
                      'updated' => '2023-07-25T14:10:34' },
          'error_code' => 0,
          'message' => 'Ok',
          'result' => true
        }
      end

      it 'returns request data' do
        expect(result).to eql(response)
      end
    end
  end

  xdescribe '#hold_funds' do
    subject(:result) { invoice.hold_funds(request_data) }

    context 'when request_data is valid', vcr: 'invoice/hold_funds' do
      let(:request_data) do
        {}
      end

      let(:response) do
        {}
      end

      it 'returns request data' do
        expect(result).to eql(response)
      end
    end
  end

  xdescribe '#unhold_funds' do
    subject(:result) { invoice.unhold_funds(request_data) }

    context 'when request_data is valid', vcr: 'invoice/unhold_funds' do
      let(:request_data) do
        {}
      end

      let(:response) do
        {}
      end

      it 'returns request data' do
        expect(result).to eql(response)
      end
    end
  end

  xdescribe '#charge' do
    subject(:result) { invoice.charge(request_data) }

    context 'when request_data is valid', vcr: 'invoice/charge' do
      let(:request_data) do
        {}
      end

      let(:response) do
        {}
      end

      it 'returns request data' do
        expect(result).to eql(response)
      end
    end
  end
end
