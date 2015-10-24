/// <reference path="../jquery-1.4.1.min.js" />
/*
Author:jackie 2010-06-11
Remark:fixed table header 
------------------------------------------------*/
; (function($) {
    $.fixedgrid = function(grid, options) { this.init(grid, options) };
    $.extend($.fixedgrid.prototype, {
        settings: {
            width: 'auto',
            height: 'auto',
            showFooter: true,
            bottomHeight: 0
        },
        init: function(grid, options) {
            $.extend(grid, this);
            $.extend(this.settings, options);
            this.grid = $(grid);
            var self = this;
            var t = this.grid;
            self.g = $('<div />').addClass('fixedgrid').attr('id', t.attr('id')).insertBefore(t);
            self.h = $('<div class="fixedgrid-header" />').append(t.clone(true).empty().append(t.find('thead'))).appendTo(self.g);
            self.b = $('<div class="fixedgrid-body" />').append(t.css('table-layout','fixed')).appendTo(self.g);

            var sw = this.settings.width == 'auto' ? '100%' : this.settings.width;
            self.setWidth(sw);

            var ol = 0;
            //self.b.find('tr:odd').addClass('odd');

            if (self.settings.height == 'auto') {
                $(window).bind("resize", function() {
                    self.autoLayout();
                }).trigger("resize");
            } else {
                self.setHeight(self.settings.height);
            }
            self.b.scroll(function() {
                var bh = $(this).scrollLeft();
                var gw = self.getWidth();
                if (ol == bh) return;
                var wh = parseFloat(t.width()) - bh; ol = bh;
                wh = wh > gw ? gw : wh;
                self.h.width(wh).scrollLeft(bh);
            });

        },
        getHeight: function() {
            return parseFloat(this.g.height()) || 0;
        },
        setHeight: function(h) {
            h = parseFloat(h) || 0;
            if (h > 0) this.b.height(h);
        },
        getWidth: function() {
            return this.g.width();
        },
        setWidth: function(w) {
            this.g.width(w);
            this.h.width(w);
            this.b.width(w);
        },
        autoLayout: function() {
            var self = this;
            var t = self.b.offset().top;
            var mb = parseFloat($("body").css('marginBottom')) || 0;
            var bh = parseFloat(self.settings.bottomHeight) || 0;
            var h = $(window).height() - t - mb - bh;
            self.b.height(h);
        }

    });
    //
    $.fn.fixedgrid = function(opts) {
        return this.each(function() {
            new $.fixedgrid(this, opts);
        });
    };

})(jQuery);
