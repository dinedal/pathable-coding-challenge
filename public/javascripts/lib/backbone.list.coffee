
List = Backbone.List = Backbone.View.extend {

  tagName: "ul"

  className: "List"

  id: "list"

  initialize: -> 
    @collection.bind 'add', @addItem, @

  render: ->
    unless @template?
      jQuery.ajax {
        url: './public/javascripts/templates/list.template'
        success: (result) =>
          @template = result.toString()
        async: false
      }
    $(@el).html( _.template( @template, {collection: @collection} ) )

  events: {
    "click .add" : "addItem"
  }

  addItem: (e) ->
    @render()

}
  
