(function() {
  var List, ListItemView;

  List = Backbone.List = Backbone.View.extend({
    tagName: "ul",
    className: "List",
    id: "list",
    initialize: function() {
      this.itemType = this.options.itemType || ListItemView;
      this.selectable = this.options.selectable;
      if (this.tagName === 'div') this.itemTagName = 'div';
      if (this.options.itemOptions != null) {
        this.itemTagName = this.options.itemOptions.tagName;
        if (this.itemTagName !== 'div' && this.itemTagName !== 'li') {
          this.wrapperTag = "li";
        }
      }
      this.collection.bind('add', this._addItem, this);
      this.collection.bind('reset', this._reset, this);
      this.collection.bind('remove', this._removeItem, this);
      return this.generateViews();
    },
    render: function() {
      var _this = this;
      this.$el = this.wrapperTag !== void 0 ? (_.map(this.views, function(view) {
        $(_this.el).append("<" + _this.wrapperTag + "></" + _this.wrapperTag + ">");
        return $(_this.el).children().first().append(view.render().el);
      }), $(this.el)) : $(this.el).html(_.map(this.views, function(view) {
        return view.render().el;
      }));
      return this;
    },
    generateViews: function() {
      var _this = this;
      return this.views = this.collection.map(function(model) {
        return _this.newListItem(model);
      });
    },
    newListItem: function(model) {
      return new this.itemType({
        model: model,
        selectable: this.selectable,
        tagName: this.itemTagName,
        childTag: this.itemChildTag,
        list: this
      });
    },
    _removeItem: function() {
      if (this.selectable && (this.selected != null)) this.selected = void 0;
      this.generateViews();
      return this.render();
    },
    _reset: function() {
      var _this = this;
      this.views = this.collection.map(function(model) {
        var old_view;
        old_view = _this.findView(model);
        if (old_view != null) {
          return old_view;
        } else {
          return _this.newListItem(model);
        }
      });
      return this.render();
    },
    _addItem: function() {
      this.generateViews();
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
    tagName: "li",
    initialize: function() {
      return this.list = this.options.list;
    },
    render: function() {
      $(this.el).html(this.model.get('text') || "");
      return this;
    },
    _remove: function() {
      return this.list.collection.remove(this.model);
    }
  });

}).call(this);
