Deface::Override.new(:virtual_path => "spree/admin/shared/_product_sub_menu",
                     :name => "collections_admin_tab",
                     :insert_bottom => "[data-hook='admin_product_sub_tabs']",
                     :text => "<%= tab(:collections) %>")
