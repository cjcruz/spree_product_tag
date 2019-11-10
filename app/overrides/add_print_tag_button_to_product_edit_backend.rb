Deface::Override.new(:virtual_path => 'spree/admin/shared/_product_tabs',
 :name => 'add_print_tag_button_to_product_edit_backend',
 :insert_bottom => "[data-hook='admin_product_tabs']",
 :text => '
  <%= content_tag :li, class: "" do %>
    <%= link_to_with_icon "tag", Spree.t(:print_master_tag, scope: :admin), 
          @product.has_variants? ? spree.admin_product_variants_url(@product) : admin_bookkeeping_document_path(@product.master.tag, format: :pdf) %>
  <% end %>
 ')