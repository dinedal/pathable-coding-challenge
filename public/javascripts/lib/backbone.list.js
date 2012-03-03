(function() {
  var List;

  List = Backbone.List = Backbone.View.extend({
    tagName: "ul",
    className: "List",
    id: "list",
    initialize: function() {
      return this.collection.bind('add', this.addItem, this);
    },
    render: function() {
      return $(this.el).html(_.template($("#list_template").html(), {
        collection: this.collection
      }));
    },
    events: {
      "click .add": "addItem"
    },
    addItem: function(e) {
      return this.render();
    }
  });

}).call(this);
