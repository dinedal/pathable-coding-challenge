
List = Backbone.List = Backbone.View.extend {

  tagName: "ul"

  className: "List"

  id: "list"

  initialize: -> 
    @collection.bind 'add', @addItem, @

  render: ->
    $(@el).html( _.template( $("#list_template").html(), {collection: @collection} ) )

  events: {
    "click .add" : "addItem"
  }

  addItem: (e) ->
    @render()

}
  
