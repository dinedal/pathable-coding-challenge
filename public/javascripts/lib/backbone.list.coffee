
List = Backbone.List = Backbone.View.extend {

  tagName: "ul"

  className: "List"

  id: "list"

  initialize: -> 
    @itemType = @options.itemType || ListItemView
    @selectable = @options.selectable
    if @options.tagName?
      @tagName = @options.tagName
      if @tagName == 'div'
        @itemTagName = @tagName

    if @options.itemOptions?
      @itemTagName = @options.itemOptions.tagName

    @collection.bind 'add', @_addItem, @
    @collection.bind 'reset', @_reset, @
    @collection.bind 'remove', @_removeItem, @
    @generateViews()

  render: ->
    @$el = $(@el).html( _.map @views, (view) ->
      view.render().el
    )
    @

  generateViews: ->
    @views = @collection.map (model) => @newListItem(model)

  newListItem: (model) ->
    new @itemType({model:model, selectable:@selectable, tagName:@itemTagName})

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
    if @options.tagName?
      if @options.tagName == 'a'
        @child_tag = 'a'
      else
        @tagName = @options.tagName


  render: ->
    if @child_tag?
      $(this.el).html(
        "<#{@child_tag}>"+
        this.model.get('text')+
        "</#{@child_tag}>"
      );
    else
      $(this.el).html(
        this.model.get('text')
      );
    @

  _remove: ->
    @list.collection.remove(this.model);

}