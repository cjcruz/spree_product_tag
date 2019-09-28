Deface::Override.new(:virtual_path => 'spree/admin/variants/index',
 :name => 'add_print_tag_button_to_variant_list_backend',
 :insert_top => "[data-hook='variants_row'] td.actions",
 :text => '
    <%= button_link_to "",
            admin_bookkeeping_document_path(variant.tag, format: :pdf),
            class: "btn btn-default btn-sm icon-link with-tip action-print-tag no-text",
            icon: "tag",
            target: :_blank,
            title: Spree.t(:print_tag, scope: :admin)
    %>
 ')