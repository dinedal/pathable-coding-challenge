
List = Backbone.List = Backbone.View.extend {

  tagName: "ul"

  className: "List"

  id: "list"

  initialize: -> 
    @itemType = @options.itemType || ListItemView
    @selectable = @options.selectable

    if @tagName == 'div'
      @itemTagName = 'div'

    if @options.itemOptions?
      @itemTagName = @options.itemOptions.tagName
      if @itemTagName != 'div' and @itemTagName != 'li'
        @wrapperTag = "li"

    @collection.bind 'add', @_addItem, @
    @collection.bind 'reset', @_reset, @
    @collection.bind 'remove', @_removeItem, @
    @generateViews()

  render: ->
    @$el = unless @wrapperTag == undefined
      _.map @views, (view) =>
        $(@el).append "<#{@wrapperTag}></#{@wrapperTag}>"
        $(@el).children().first().append(view.render().el)
      $(@el)
    else
      $(@el).html( _.map @views, (view) ->
        view.render().el
      )
    @

  generateViews: ->
    @views = @collection.map (model) => @newListItem(model)

  newListItem: (model) ->
    new @itemType({
      model:model,
      selectable:@selectable,
      tagName:@itemTagName,
      childTag:@itemChildTag,
      list:@
    })

  _removeItem: ->
    if @selectable and @selected?
      @selected = undefined
    @generateViews()
    @render()

  _reset: ->
    @views = @collection.map (model) =>
      old_view = @findView(model)
      if old_view?
        old_view
      else
        @newListItem(model)
    @render()

  _addItem: ->
    @generateViews()
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

  tagName: "li"

  initialize: ->
    @list = @options.list


  render: ->
    $(@el).html(
      @model.get('text') || ""
    );
    @

  _remove: ->
    @list.collection.remove(@model);

}