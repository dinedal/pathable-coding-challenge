(function() {
  var List;

  List = Backbone.List = Backbone.View.extend({
    tagName: "ul",
    className: "List",
    id: "list",
    initialize: function() {
      this.itemType = this.options.itemType;
      this.collection.bind('add', this.render, this);
      this.collection.bind('reset', this.render, this);
      return this.collection.bind('remove', this.render, this);
    },
    render: function() {
      var _this = this;
      return $(this.el).html(this.collection.map(function(model) {
        return new _this.itemType({
          model: model
        }).render().el;
      }));
    }
  });

}).call(this);
