(function() {
  var List, ListItemView;

  List = Backbone.List = Backbone.View.extend({
    tagName: "ul",
    className: "List",
    id: "list",
    initialize: function() {
      this.itemType = this.options.itemType || ListItemView;
      this.selectable = this.options.selectable;
      this.collection.bind('add', this.render, this);
      this.collection.bind('reset', this.render, this);
      return this.collection.bind('remove', this._removeItem, this);
    },
    render: function() {
      var _this = this;
      this.views = this.collection.map(function(model) {
        var old_view;
        old_view = _this.findView(model);
        if (old_view != null) {
          return old_view;
        } else {
          return new _this.itemType({
            model: model,
            selectable: _this.selectable
          });
        }
      });
      $(this.el).html(_.map(this.views, function(view) {
        return view.render().el;
      }));
      return this;
    },
    _removeItem: function() {
      if (this.selectable && (this.selected != null)) this.selected = void 0;
      return this.render();
    },
    findView: function(param) {
      if (param.id != null) param = param.id;
      if (param.cid != null) param = param.cid;
      return _.find(this.views, function(view) {
        return (view.cid === param) || (view.model.cid === param) || (view.model.id === param);
      });
    },
    select: function(param) {
      if (this.selectable) return this.selected = this.findView(param);
    }
  });

  ListItemView = Backbone.View.extend({
    initialize: function() {
      return this.list = this.options.list;
    },
    render: function() {
      $(this.el).html(this.model.get('text'));
      return this;
    },
    _remove: function() {
      return this.list.collection.remove(this.model);
    }
  });

}).call(this);
