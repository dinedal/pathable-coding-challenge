(function() {
  var List;

  List = Backbone.List = Backbone.View.extend({
    tagName: "ul",
    className: "List",
    id: "list",
    initialize: function() {
      return this.render();
    },
    render: function() {
      return $(this.el).html(_.template($("#list_template").html(), {
        collection: this.collection
      }));
    }
  });

}).call(this);
