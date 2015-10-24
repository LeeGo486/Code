define(function(require, exports, module){
	
	//�������ģ��
	var $ = require('lib/zepto/zepto'),
		$ = require('lib/zepto/data');

	//ע��AnimationCloudBg���
	(function () {
		//����AnimationCloudBg�������
		var AnimationCloudBg = function ($item, options) {
			//��������
			this.$target = $item.addClass('m-animationCloudBg');

			this.$target.height(window.innerHeight);

			//ѭ������Ƶ�i���
			for(var i=1; i<13; i++){
				var $cloudItem = $('<i></i>');
				$item.append($cloudItem);
			}
		};
		//��������
		AnimationCloudBg.prototype.start = function () {
			//�Ƴ�ֹͣ����class
			this.$target.removeClass('z-stop');
		}
		//ֹͣ����
		AnimationCloudBg.prototype.stop = function () {
			//���ֹͣ����class
			this.$target.addClass('z-stop');
		}

		//ע��animationCloudBg����ӿ�
		$.fn.animationCloudBg = function (options) {
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
						//ʵ����AnimationCloudBg����
						var pluginObj = new AnimationCloudBg($item);
						//����ǰ������󱣴浽data��
						$item.data('plugin_animationcloudbg', pluginObj);
					});
				break;
				//�����ʼ��
				case 'getPluginObject':
					//����ǰ������󱣴浽data��
					return $item.data('plugin_animationcloudbg');
				break;
				//�����ʼ��
				case 'start':
					//��ȡ�������
					var pluginObj = this.data('plugin_animationcloudbg');
					pluginObj.start();
				break;
				//�����ʼ��
				case 'stop':
					//����ǰ������󱣴浽data��
					return $item.data('plugin_animationcloudbg');
					pluginObj.stop();
				break;
			}

			//���ֲ�����
			return this;
		};
	})();

	module.exports = $;
});