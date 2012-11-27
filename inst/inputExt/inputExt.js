
jQuery(function($) {
  // Password Input
  var passwordInputBinding = new Shiny.InputBinding();
  $.extend(passwordInputBinding, {
    find: function(scope) {
      return $(scope).find('input[type="password"]');
    },
    getId: function(el) {
      return Shiny.InputBinding.prototype.getId.call(this, el) || el.name;
    },
    getValue: function(el) {
      return el.value;
    },
    setValue: function(el, value) {
      el.value = value;
    },
    subscribe: function(el, callback) {
      $(el).on('keyup.passwordInputBinding input.passwordInputBinding', function(event) {
        callback(true);
      });
      $(el).on('change.passwordInputBinding', function(event) {
        callback(false);
      });
    },
    unsubscribe: function(el) {
      $(el).off('.passwordInputBinding');
    },
    getRatePolicy: function() {
      return {
        policy: 'debounce',
        delay: 250
      };
    }
  });
  Shiny.inputBindings.register(passwordInputBinding, 'shiny.passwordInput');
  
  //Action Button
  var actionButtonBinding = new Shiny.InputBinding();
  $.extend(actionButtonBinding, {
    find: function(scope) {
      return $(scope).find(".action-button");
    },
    getValue: function(el) {
      var val = $(el).data('val') || 0;
      $(el).data('val', val + 1);
      return val;
    },
    setValue: function(el, value) {
    },
    subscribe: function(el, callback) {
      $(el).on("click.actionButton", function(e) {
        callback();
      });
    },
    unsubscribe: function(el) {
      $(el).off(".actionButton");
    }
  });
  Shiny.inputBindings.register(actionButtonBinding);
  
  // daterangePicker
  var daterangePickerBinding = new Shiny.InputBinding();
  $.extend(daterangePickerBinding, {
    find: function(scope) {
      return $(scope).find('input[name="daterange-picker"]');
    },
    getId: function(el) {
      return Shiny.InputBinding.prototype.getId.call(this, el) || el.name;
    },
    getValue: function(el) {
      return el.value;
    },
    setValue: function(el, value) {
      el.value = value;
    },
    subscribe: function(el, callback) {
      $(el).on('keyup.daterangePickerBinding input.daterangePickerBinding', function(event) {
        callback(true);
      });
      $(el).on('change.daterangePickerBinding', function(event) {
        callback(false);
      });
    },
    unsubscribe: function(el) {
      $(el).off('.daterangePickerBinding');
    },
    getRatePolicy: function() {
      return {
        policy: 'debounce',
        delay: 250
      };
    }    
  });
  Shiny.inputBindings.register(daterangePickerBinding, 'shiny.daterangePicker');
//  var drp = $.find('input[name=daterange-picker]');
//  $(drp).daterangepicker();
})
