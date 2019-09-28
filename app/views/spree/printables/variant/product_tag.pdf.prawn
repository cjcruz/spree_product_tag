@font_style = {
  face: Spree::PrintInvoice::Config[:font_face],
  size: Spree::PrintInvoice::Config[:font_size]
}

#Size is 8x3cm
prawn_document(force_download: true, 
                page_size: [ 85.039370079, 226.771653543],
                margin: [14.173228346, 7.086614173, 7.086614173, 7.086614173]) do |pdf|

  pdf.define_grid(rows: 15, columns: 1, gutter: 0)
  pdf.font @font_style[:face], size: @font_style[:size]

  #pdf.grid.show_all

  pdf.grid([0,0], [2,0]).bounding_box do
    im = Rails.application.assets.find_asset(Spree::PrintInvoice::Config[:logo_path])

    if im && File.exist?(im.pathname)
      pdf.image im.filename, vposition: :center, height: 35, scale: Spree::PrintInvoice::Config[:logo_scale], position: :center, vposition: :center
    end
  end
  

  # name
  pdf.grid([3,0], [5,0]).bounding_box do
    pdf.text @doc.name, size: 8, style: :normal, align: :center, valign: :top
  end

  # barcode
  pdf.grid([6,0], [12,0]).bounding_box do
    pdf.rotate(90, origin: [0, 0]) do
      pdf.translate(0,-57)
      @doc.barcode.annotate_pdf(pdf, height: 40)
    end

    pdf.translate(-25,0) do
      pdf.text @doc.code, size: 8, style: :normal, rotate: -90, rotate_around: :center, align: :center, valign: :center
    end
  end

  # price
  pdf.grid([13,0], [14,0]).bounding_box do
    pdf.text @doc.display_price, size: 14, style: :bold, align: :center, valign: :bottom
  end

end