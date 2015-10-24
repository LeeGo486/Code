define(function(require, exports, module){
	
	//�������ģ��
	var $ = require('lib/zepto/zepto'),
		$ = require('lib/zepto/touch'),
		$ = require('lib/zepto/data');

	//ע��MeteorShower���
	(function () {
		//����MeteorShower�������
		var MeteorShower = function ($item, options) {
			var theClass = this;
			//��������
			this.$target = $item.addClass('m-meteorShower');
			this.settings = $.extend({
				starCount : 30,
				meteorCount : 20
			}, options);


			//��ʱ����
			var left, top, styleIndex, delay, duration, scale;

			//��������
			var html = '';
			for(var i = 0; i < this.settings.starCount; i++){
				//��������ֵ
				left = (Math.random() * 640).toFixed(2);
				top = (Math.random() * 600).toFixed(2);
				delay = Math.random().toFixed(2);
				duration = (1 + Math.random() * (5 - 1)).toFixed();
				styleIndex = Math.round(1 + Math.random() * (4-1));
				//����һ������
				html += '<i class="star style'+ styleIndex +'" style="left:'+ left +'px; top:'+ top +'px; -webkit-animation-delay:'+ delay +'s; -webkit-animation: star '+ duration +'s linear infinite;"></i>';
			}

			//��������
			for(var i = 0; i < this.settings.meteorCount; i++){
				//��������ֵ
				left = (Math.random() * 800 - 280).toFixed(2);
				top = (Math.random() * 100 - 80).toFixed(2);
				delay = (0.5 + Math.random() * (3 - 0.5)).toFixed();
				duration = (1.2 + Math.random() * (4 - 1.2)).toFixed();
				styleIndex = Math.round(1 + Math.random() * (4-1));
				//����һ������
				html += '<i class="meteor style'+ styleIndex +'" style="left:'+ left +'px; top:'+ top +'px; -webkit-animation-delay:'+ delay +'s; -webkit-animation: meteor '+ duration +'s linear infinite;"></i>';
			}

			//��������ӵ�����
			this.$target.append(html);
		};

		//ע��meteorShower����ӿ�
		$.fn.meteorShower = function (options) {
			//��ȡָ��
			var command = 'init';
			if(arguments.length > 0){
				if (typeof arguments[0] == 'string'){
					command = arguments[0];
				}
			}

			//�ж�ָ��
			switch(command){
				//�����ʼ��
				case 'init':
					//ѭ������
					this.each(function (i, item) {
						var $item = $(item);
						//ʵ����MeteorShower����
						var pluginObj = new MeteorShower($item);
						//����ǰ������󱣴浽data��
						$item.data('plugin_meteorShower', pluginObj);
					});
				break;
				//�����ʼ��
				case 'getPluginObject':
					//����ǰ������󱣴浽data��
					return $item.data('plugin_meteorShower');
				break;
			}

			//���ֲ�����
			return this;
		};
	})();

	module.exports = $;
});