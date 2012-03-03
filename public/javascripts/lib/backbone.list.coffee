
List = Backbone.List = Backbone.View.extend {

  tagName: "ul"

  className: "List"

  id: "list"

  initialize: -> 
    @itemType = @options.itemType
    @collection.bind 'add', @render, @
    @collection.bind 'reset', @render, @
    @collection.bind 'remove', @render, @

  render: ->
    $(@el).html( @collection.map (model) => 
      new @itemType({model:model}).render().el
    )
}
  
