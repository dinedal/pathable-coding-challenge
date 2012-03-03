
List = Backbone.List = Backbone.View.extend {

  tagName: "ul"

  className: "List"

  id: "list"

  initialize: -> 
    @itemType = @options.itemType || ListItemView
    @selectable = @options.selectable
    @collection.bind 'add', @render, @
    @collection.bind 'reset', @render, @
    @collection.bind 'remove', @_removeItem, @

  render: ->
    @views = @collection.map (model) =>
      old_view = @findView(model)
      if old_view?
        old_view
      else
        new @itemType({model:model, selectable:@selectable})
    $(@el).html( _.map @views, (view) -> 
      view.render().el
    )
    @

  _removeItem: ->
    if @selectable and @selected?
      @selected = undefined
    @render()

  findView: (param) ->
    param = param.id if param.id?
    param = param.cid if param.cid?
    _.find(@views, (view) -> (view.cid == param) || (view.model.cid == param) || (view.model.id == param))

  select: (param) ->
    if @selectable
      @selected = @findView(param)

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