module Jekyll
  class CollapsibleTagBlock < Liquid::Block

    def render(context)
      @text = super

      site = context.registers[:site]
      converter = site.find_converter_instance(::Jekyll::Converters::Markdown)
      @parsedText = converter.convert(@text)

      <<~COLLAPSIBLEBLOCK
<!-- Begin collapsible container div -->
<div class="collapsible-content-container">
  <!-- Begin collapsible container button -->
<<<<<<< HEAD
  <button class="toggle-collapsible">Click</button>
=======
  <button class="toggle-collapsible">Toggle</button>
>>>>>>> b0c072bd7458c10a6b19872faeec75260aa34f67
  <!-- Begin collapsible container content div -->
  <div class="collapsible-content">
    <!-- Begin parsedText -->
    #{@parsedText}
    <!-- End parsedText -->
  </div>
  <!-- End collapsible container content div -->
</div>
<!-- End collapsible container div -->
      COLLAPSIBLEBLOCK

    end

  end
end

Liquid::Template.register_tag('collapsible', Jekyll::CollapsibleTagBlock)