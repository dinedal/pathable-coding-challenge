
List = Backbone.List = Backbone.View.extend {

  tagName: "ul"

  className: "List"

  id: "list"

  initialize: -> 
    @itemType = @options.itemType || ListItemView
    @collection.bind 'add', @render, @
    @collection.bind 'reset', @render, @
    @collection.bind 'remove', @render, @


  render: ->
    @views = @collection.map (model) =>
      new @itemType({model:model})
    $(@el).html( _.map @views, (view) -> 
      view.render().el
    )
    @

  generateViews: ->
    @views = @collection.map (model) =>
      new @itemType({model:model})

  findView: (param) ->
    param = param.id if param.id?
    param = param.cid if param.cid?
    _.find(@views, (view) -> (view.cid == param) || (view.model.cid == param) || (view.model.id == param))
}
  
ListItemView = Backbone.View.extend {

    initialize: ->
      @list = @options.list

    render: ->
      $(this.el).html(
        this.model.get('text')
      );
      return this;

    _remove: ->
      @list.collection.remove(this.model);

}