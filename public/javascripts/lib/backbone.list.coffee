
List = Backbone.List = Backbone.View.extend {

  tagName: "ul"

  className: "List"

  id: "list"

  initialize: -> 
    @render()

  render: ->
    $(@el).html( _.template( $("#list_template").html(), {collection: @collection} ) )

}
  
