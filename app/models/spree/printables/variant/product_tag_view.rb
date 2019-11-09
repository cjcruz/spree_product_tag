require 'barby'
require 'barby/barcode/ean_13'
require 'barby/outputter/prawn_outputter'

module Spree
  class Printables::Variant::ProductTagView < Printables::BaseView
    # def_delegators :order,
    #                 :email,
    #                 :bill_address,
    #                 :ship_address

    def_delegators :@printable,
                    :name,
                    :display_price,
                    :display_affiliate_price

    def number
    end

    def firstname
    end

    def lastname
    end

    def email
    end

    def item_total
    end

    def total
    end

    def code 
      code = printable.sku.rjust(12, "0")
    end

    def barcode
      Barby::EAN13.new code
    end

    def after_save_actions
      increase_invoice_number! if use_sequential_number?
    end    

    private

    def increase_invoice_number!
      Spree::PrintInvoice::Config.increase_invoice_number!
    end

    def use_sequential_number?
      @_use_sequential_number ||=
        Spree::PrintInvoice::Config.use_sequential_number?
    end
  end
end