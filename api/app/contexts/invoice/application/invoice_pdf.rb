require "prawn"

class InvoicePdf < Prawn::Document
  def initialize
    # Default state of the pdf would state to this code
    super
    # Uncomment the below line if you wish for some custom rearrangements in the default state. like for ex
    # super(top_margin: 100)  
  end
  
  # Now start defining methods and perform operations for your PDF.
  def header
    move_down 30  # This will move down the start of pdf by 30 pixels.
    text "My Header" , :style => :bold , :size => 14 # obviously, the size and style can be customized.
    text "#{Date.today}" , :style => :bold , :size => 5 # You can use Interpolation and rails as is, obviously.
  end

end