Spree::Api::V1::VariantsController.class_eval do

  before_action :prepare_for_product_name_or_sku_search, only: :index

  private

  def prepare_for_product_name_or_sku_search
    if params[:q].has_key?(:product_name_or_sku_cont)
      params[:q][:product_name_or_sku_cont] = params[:q][:product_name_or_sku_cont].sub!(/^0+/, "")
    end
  end

end