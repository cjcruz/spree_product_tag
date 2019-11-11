require 'barby'
require 'barby/barcode/code_128'
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

    def size
      printable.option_values.joins(:option_type).where(spree_option_types: {name: ['talla-alfabetica', 'talla-numerica']}).first
    end

    def color
      printable.option_values.joins(:option_type).where(spree_option_types: {name: 'color'}).first
    end

    def barcode
      Barby::Code128.new code
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