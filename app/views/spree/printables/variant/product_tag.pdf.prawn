@font_style = {
  face: Spree::PrintInvoice::Config[:font_face],
  size: Spree::PrintInvoice::Config[:font_size]
}

#Size is 8x3cm
prawn_document(force_download: true, 
                page_size: [ 85.039370079, 226.771653543],
                margin: [14.173228346, 7.086614173, 7.086614173, 7.086614173]) do |pdf|

  pdf.define_grid(rows: 20, columns: 3, gutter: 0)
  pdf.font @font_style[:face], size: @font_style[:size]
  
  #pdf.grid.show_all


  # instagram
  pdf.grid([1,0], [1,2]).bounding_box do
    pdf.text_box '@tiendasgarage', size: 9, style: :bold, align: :center, valign: :center, overflow: :truncate
  end

  # logo
  pdf.grid([3,0], [4,0]).bounding_box do
    im = Rails.application.assets.find_asset('logo_tg_black.png')

    if im && File.exist?(im.pathname)
      pdf.image im.filename, height: 20, scale: Spree::PrintInvoice::Config[:logo_scale], 
                position: :center, vposition: :top
    end
  end

  # barcode
  pdf.grid([5,0], [14,0]).bounding_box do
    pdf.rotate(90, origin: [0, 0]) do
      pdf.translate(0,-20)
      @doc.barcode.annotate_pdf(pdf, height: 20)
    end
  end

  # name
  pdf.grid([2,1], [6,2]).bounding_box do
    pdf.text_box @doc.name, size: 8, style: :normal, align: :center, valign: :center, overflow: :truncate
  end

  #sku
  pdf.grid([7,1], [8,2]).bounding_box do
    pdf.text 'Código', size: 8, style: :normal, align: :center
    pdf.text @doc.code.sub!(/^0+/, ""), size: 8, style: :normal, align: :center
  end

  
  # option types
  pdf.grid([9,1], [14,2]).bounding_box do
    pdf.text 'Talla', size: 8, style: :normal, align: :center
    pdf.text 'M', size: 14, style: :bold, align: :center
    pdf.move_down 2
    pdf.text 'Color', size: 8, style: :normal, align: :center
    pdf.text 'Concho de vino', size: 8, style: :bold, align: :center
  end

  # price
  pdf.grid([15,0], [19,2]).bounding_box do
    pdf.move_down 7
    pdf.text "<font character_spacing='1.5'>P.V.Afiliado</font>", 
                inline_format: true, size: 5, style: :normal, align: :center
    pdf.text '$4.00', size: 7, style: :normal, align: :center
    pdf.move_down 3
    pdf.text "<font character_spacing='1.5'>P.V.P.</font>", 
                inline_format: true, size: 5, style: :normal, align: :center
    pdf.text @doc.display_price, size: 14, style: :bold, align: :center

    pdf.text '* Precios incluyen IVA', size: 5, style: :normal, align: :center
  end

end