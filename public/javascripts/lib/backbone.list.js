(function() {
  var List, ListItemView;

  List = Backbone.List = Backbone.View.extend({
    tagName: "ul",
    className: "List",
    id: "list",
    initialize: function() {
      this.itemType = this.options.itemType || ListItemView;
      this.collection.bind('add', this.render, this);
      this.collection.bind('reset', this.render, this);
      return this.collection.bind('remove', this.render, this);
    },
    render: function() {
      var _this = this;
      this.views = this.collection.map(function(model) {
        return new _this.itemType({
          model: model
        });
      });
      $(this.el).html(_.map(this.views, function(view) {
        return view.render().el;
      }));
      return this;
    },
    generateViews: function() {
      var _this = this;
      return this.views = this.collection.map(function(model) {
        return new _this.itemType({
          model: model
        });
      });
    },
    findView: function(param) {
      if (param.id != null) param = param.id;
      if (param.cid != null) param = param.cid;
      return _.find(this.views, function(view) {
        return (view.cid === param) || (view.model.cid === param) || (view.model.id === param);
      });
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
