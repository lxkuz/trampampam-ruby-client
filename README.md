# Contactpay

Ruby client for Contactpay API

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add contactpay

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install contactpay

## Usage

### Configure

When you get your Site approved you can use it's secret key for making API requests.

```ruby
  require 'contactpay'

  contactpay_config = Contactpay::Config.new(
    base_url: "<BASE API URL>", # "https://api.contactpay.com.com"
    account_secret_key: "<YOUR ACCOUNT SECRET KEY>",
    shop_id: <YOUR ACCOUNT SHOP ID>,
    faraday_block: # if needed
  )
```
Now you can make API calls

### Balance

#### To get yoour account balance:
```ruby
  Contactpay::Shop.new(contactpay_config).balance
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/other-shop-methods/operation/post-shop-balance)

### Invoice

#### To get invoice prelim calculation result:

```ruby
  data = { ... }
  Contactpay::Invoice.new(contactpay_config).prelim_calc(data)
```

See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-create/operation/post-invoice-try)

#### To create invoice:

```ruby
  data = { ... }
  Contactpay::Invoice.new(contactpay_config).create(data)
```

See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-create/operation/post-invoice-create)

#### To get invoice status:

```ruby
  data = { ... }
  Contactpay::Invoice.new(contactpay_config).status(data)
```

See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-create/operation/post-invoice-check)

#### To charge hold funds:
```ruby
  data = { ... }
  Contactpay::Invoice.new(contactpay_config).hold_funds(data)
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-create/operation/post-invoice-hold)

#### To charge invoice funds:
```ruby
  data = { ... }
  Contactpay::Invoice.new(contactpay_config).charge(data)
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-create/operation/post-invoice-charge)

#### To charge unhold funds:
```ruby
  data = { ... }
  Contactpay::Invoice.new(contactpay_config).unhold_funds(data)
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-create/operation/post-invoice-unhold)

####  To get payment methods for input
```ruby
  Contactpay::Invoice.new(contactpay_config).payment_methods
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-create/operation/post-shop-input-config-shop)

### Withdraw

#### To get withdraw prelim calculation result:

```ruby
  data = { ... }
  Contactpay::Withdraw.new(contactpay_config).prelim_calc(data)
```

See [API method reference](https://docs.contactpay.com/?lang=en#tag/withdraw-create/operation/post-withdraw-try)

#### To check the account for the possibility of replenishment:

```ruby
  data = { ... }
  Contactpay::Withdraw.new(contactpay_config).check_account(data)
```

See [API method reference](https://docs.contactpay.com/?lang=en#tag/withdraw-create/operation/post-withdraw-check-account)

#### To create withdraw:

```ruby
  data = { ... }
  Contactpay::Withdraw.new(contactpay_config).create(data)
```

See [API method reference](https://docs.contactpay.com/?lang=en#tag/withdraw-create/operation/post-withdraw-create)


#### To get withdraw status by ID:

```ruby
  data = { ... }
  Contactpay::Withdraw.new(contactpay_config).status_by_id(data)
```

See [API method reference](https://docs.contactpay.com/?lang=en#tag/withdraw-create/operation/post-withdraw-status)

#### To get withdraw status by shop payout number:

```ruby
  data = { ... }
  Contactpay::Withdraw.new(contactpay_config).status_by_shop_number(data)
```

#### To get possible payout methods
```ruby
  Contactpay::Withdraw.new(contactpay_config).payment_methods
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/withdraw-create/operation/post-shop-output-config-shop)

### Refund

#### Invoice refund
```ruby
  data = { ... }
  Contactpay::Refund.new(contactpay_config).create(data)
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-refund/operation/post-invoice-create-refund)

#### Invoice refund status
```ruby
  data = { ... }
  Contactpay::Refund.new(contactpay_config).status(data)
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-refund/operation/post-invoice-get-status-refunds)

### Recurrent invoice

#### Payment token issue
```ruby
  data = { ... }
  Contactpay::PaymentToken.new(contactpay_config).create(data)
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-recurrent/operation/post-create-payment-token)

#### Payment token issue confirmation

```ruby
  data = { ... }
  Contactpay::PaymentToken.new(contactpay_config).complete(data)
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-recurrent/operation/post-complete-payment-token)

#### Payment token issue status

```ruby
  data = { ... }
  Contactpay::PaymentToken.new(contactpay_config).status(data)
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-recurrent/operation/post-get-status-payment-token)

#### Payment token deletion

```ruby
  data = { ... }
  Contactpay::PaymentToken.new(contactpay_config).delete(data)
```
See [API method reference](https://docs.contactpay.com/?lang=en#tag/invoice-recurrent/operation/post-delete-payment-token)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/contactpay. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/contactpay/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Contactpay project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/contactpay/blob/main/CODE_OF_CONDUCT.md).
