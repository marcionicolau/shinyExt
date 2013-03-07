

var tableInputBinding = new Shiny.InputBinding();
  $.extend(tableInputBinding, {
    find: function(scope) {
      return scope.find('.handsonTable-output');
    },
    getValue: function(el) {

      var data_encoded = $(el).handsontable('getData');
      return JSON.stringify(data_encoded);
    },
    setValue: function(el) {
    
    },
    subscribe: function(el, callback) {
      $(el).on('change.tableInputBinding', function(e) { callback(); });
    },
    unsubscribe: function(el) {
      $(el).off('.tableInputBinding')
    }
  });
  Shiny.inputBindings.register(tableInputBinding);

var tableOutputBinding = new Shiny.OutputBinding();
  $.extend(tableOutputBinding, {
    find: function(scope) {
      return scope.find('.handsonTable-output');
    },
    renderValue: function(el, data) {
      $(el).handsontable({
        data: JSON.parse(data),
        startRows: 5,
        startCols: 5,
        minSpareCols: 1,
        //always keep at least 1 spare row at the right
        minSpareRows: 1,
        //always keep at least 1 spare row at the bottom,
        rowHeaders: true,
        colHeaders: true,
        contextMenu: true
      });
  	}
  });
Shiny.outputBindings.register(tableOutputBinding, "handsonTable-output");
