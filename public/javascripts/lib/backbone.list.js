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
      var _this = this;
      if (this.template == null) {
        jQuery.ajax({
          url: './public/javascripts/templates/list.template',
          success: function(result) {
            return _this.template = result.toString();
          },
          async: false
        });
      }
      return $(this.el).html(_.template(this.template, {
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
