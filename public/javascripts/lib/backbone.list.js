(function() {
  var List;

  List = Backbone.List = Backbone.View.extend({
    tagName: "ul",
    className: "List",
    id: "list",
    initialize: function() {
      this.collection.bind('add', this.addItem, this);
      return this.collection.bind('reset', this.resetList, this);
    },
    render: function() {
      var _this = this;
      if (this.template == null) {
        jQuery.ajax({
          url: './public/javascripts/templates/list.template',
          success: function(result) {
            return _this.template = result;
          },
          async: false
        });
      }
      return $(this.el).html(_.template(this.template, {
        collection: this.collection
      }));
    },
    addItem: function(e) {
      return this.render();
    },
    resetList: function(e) {
      return this.render();
    }
  });

}).call(this);
