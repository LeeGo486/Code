$.editable.addInputType('numeric', {
    element: function(settings, original) {
        var input = $('<input class="numeric"/>');
        var that = $(this);
        input.width(settings.width);
        jQuery(input).numeric(settings.numeric).css('ime-mode', 'disabled');
        that.append(input)
        return input;
    },
    submit: function(settings, original) {
        var value = parseInt($('input', this).val()) || '';
        $('input', this).val(value);
    }
});