class Transformable
  constructor: (transformable) ->
    @matrix = $M([ [1, 0, 0],
                   [0, 1, 0],
                   [0, 0, 1] ])
    @transformable = transformable

    @translate_x = ko.observable(0)
    @translate_y = ko.observable(0)
    @rotation = ko.observable(0)

  render: ->
    @transformable.css("-webkit-transform", "matrix(#{@css_matrix()})")
    
  on_translate: =>
    @translate(parseInt(@translate_x(), 10), parseInt(@translate_y(), 10))
    @translate_x(0)
    @translate_y(0)

  on_rotate: =>
    @rotate(parseInt(@rotation(), 10))
    @rotation(0)
  # Public methods

  rotate: (deg) ->
    cos = Math.round(Math.cos(deg*Math.PI/180)*100)/100;
    sin = Math.round(Math.sin(deg*Math.PI/180)*100)/100;


    @matrix = @matrix.x $M([ [cos, sin, 0],
                             [-sin, cos, 0],
                             [0, 0, 1] ])
    @render()

  translate: (x = 0, y = 0) ->
    @matrix = @matrix.add $M([ [0, 0, x],
                               [0, 0, y],
                               [0, 0, 0] ])
    @render()
  css_matrix: ->
    row_1 = @matrix.row(1)
    row_2 = @matrix.row(2)
    "#{row_1.e(1)}, #{row_2.e(1)}, #{row_1.e(2)}, #{row_2.e(2)}, #{row_1.e(3)}, #{row_2.e(3)}"


# transformable = new Transformable $(".transformable"), $(".controls")
ko.applyBindings(new Transformable($(".transformable")), $(".controls")[0])