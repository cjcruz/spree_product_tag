Spree::Api::V1::VariantsController.class_eval do

  before_action :prepare_for_product_name_or_sku_search, only: :index

  private

  def prepare_for_product_name_or_sku_search
    if params[:q].has_key?(:product_name_or_sku_cont) && 
      !!(params[:q][:product_name_or_sku_cont] =~ /\A[-+]?[0-9]+\z/) #if it is numeric
      params[:q][:product_name_or_sku_cont] = params[:q][:product_name_or_sku_cont].to_i.to_s
    end
  end

end