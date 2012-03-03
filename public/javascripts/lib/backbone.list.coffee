
List = Backbone.List = Backbone.View.extend {

  tagName: "ul"

  className: "List"

  id: "list"

  initialize: -> 
    @collection.bind 'add', @addItem, @
    @collection.bind 'reset', @resetList, @

  render: ->
    unless @template?
      jQuery.ajax {
        url: './public/javascripts/templates/list.template'
        success: (result) =>
          @template = result
        async: false
      }
    $(@el).html( _.template( @template, {collection: @collection} ) )

  addItem: (e) ->
    @render()

  resetList: (e) ->
    @render()

}
  
