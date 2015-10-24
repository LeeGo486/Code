define(function(require, exports, module){
	
	//���ù��ܿ�ģ��
	var $ = require('lib/zepto/zepto'),					//zeptoģ��
		$ = require('lib/zepto/selector');				//ѡ�������ģ��

	//����appȫ��ģ��
	var globalAudio = require('units/globalAudio');		//ȫ����Ƶģ��
	
	//App��
	var App = function ($item) {
		console.log('app init');

		//�������Զ���
		this._$app = $item;							//app������װ����
		this._$pages = this._$app.find('.page');	//app�����е�ҳ�漯��
		this.$currentPage = this._$pages.eq(0);		//��ǰ��ʾ��ҳ��
		this._isFirstShowPage = true;				//�Ƿ��һ����ʾҳ��
		this._isInitComplete = false;				//�Ƿ��ʼ���Ѿ����
		this._isDisableFlipPage = false;			//�Ƿ��ֹ��ҳ
		this._isDisableFlipPrevPage = false;		//�Ƿ��ֹ���Ϸ�ҳ
		this._isDisableFlipNextPage = false;		//�Ƿ��ֹ���·�ҳ

		//�������
		var theClass = this;
		var $win = $(window);

		//���ò���Ҫ�������Ĭ����Ϊ
		(function () {
			//��ֹios���������������
			$win.on('scroll.elasticity', function (e) {
				e.preventDefault();
			}).on('touchmove.elasticity', function (e) {
				e.preventDefault();
			});

			//��ֹ�϶�ͼƬ
			$win.delegate('img', 'mousemove', function (e) {
				e.preventDefault();
			});
		})();

		//��ʼ��ҳ���л�Ч��
		$win.on('load', function (e) {
			//������ʱ����
			var currentPage = null, activePage = null;
			var triggerLoop = false;
			var startX = 0, startY = 0, moveDistanceX = 0, moveDistanceY = 0, isStart = false, isNext = false, isFirstTime = true;
			//ΪtheClass._$app����¼�
			theClass._$app.on('mousedown touchstart', function (e) {
				//������������ʱ���ֹ��ҳʱ��������һ���л�
				if(theClass._isDisableFlipPage){
					return;
				}
				//��ȡ��ǰ��ʾ��ҳ��ͽ�Ҫ��ʾ��ҳ��
				currentPage = theClass._$pages.filter('.z-current').get(0);
				activePage = null;
				//��ʼ���л�����������
				if(currentPage){
					isStart = true;
					isNext = false;
					isFirstTime = true;
					moveDistanceX = 0;
					moveDistanceY = 0;
					if(e.type == 'mousedown'){
						startX = e.pageX;
						startY = e.pageY;
					}else{
						startX = e.touches[0].pageX;
						startY = e.touches[0].pageY;
					}
					currentPage.classList.add('z-move');
					currentPage.style.webkitTransition = 'none';
				}
			}).on('mousemove touchmove', function (e) {
				//��������һ���л����ҽ�Ҫ��ʾ��ҳ�治Ϊnull����Ϊ�������һ�ν���move�¼�
				if(isStart && (activePage || isFirstTime)){
					//��ȡ�ƶ�����
					if(e.type == 'mousemove'){
						moveDistanceX = e.pageX - startX;
						moveDistanceY = e.pageY - startY;
					}else{
						moveDistanceX = e.touches[0].pageX - startX;
						moveDistanceY = e.touches[0].pageY - startY;
					}

					//���Y�ƶ��ľ������X�ƶ��ľ��룬����з�ҳ����
					if(Math.abs(moveDistanceY) > Math.abs(moveDistanceX)){
						//�ж��û������ϻ���������
						if(moveDistanceY > 0){
							//�ж��Ƿ��Ѿ��������·�ҳ
							if(theClass._isDisableFlipPrevPage){
								return;
							}
							//����������ʾ��һҳ
							if(isNext || isFirstTime){
								//������ʱ����ֵ
								isNext = false;
								isFirstTime = false;
								//����ϴν�Ҫ��ʾ��ҳ��
								if(activePage){
									activePage.classList.remove('z-active');
									activePage.classList.remove('z-move');
								}
								//��ȡ��ǰ��Ҫ��ʾ����һҳ
								if(currentPage.previousElementSibling && currentPage.previousElementSibling.classList.contains('page')){
									activePage = currentPage.previousElementSibling;
								} else {
									if(triggerLoop) {
										activePage = theClass._$pages.last().get(0)
									} else {
										activePage = false;
									}
								}
								if(activePage && activePage.classList.contains('page')){
										//��ȡ�ɹ�����ʼ����һҳ
										activePage.classList.add('z-active')
										activePage.classList.add('z-move');
										activePage.style.webkitTransition = 'none';
										activePage.style.webkitTransform = 'translateY(-100%)';
										$(activePage).trigger('active');
										currentPage.style.webkitTransformOrigin = 'bottom center';
								}else{
									//��ȡʧ�ܣ����õ�ǰҳ
									currentPage.style.webkitTransform = 'translateY(0px) scale(1)';
									activePage = null;
								}
							}else{
								//�ƶ�ʱ������ʽ
								currentPage.style.webkitTransform = 'scale('+ (window.innerHeight / (window.innerHeight + moveDistanceY)).toFixed(3) +')';
								activePage.style.webkitTransform = 'translateY(-'+ (window.innerHeight - moveDistanceY) +'px)';
							}
						}else if(moveDistanceY < 0){
							//�ж��Ƿ��Ѿ��������Ϸ�ҳ
							if(theClass._isDisableFlipNextPage){
								return;
							}
							//����������ʾ��һҳ
							if(!isNext || isFirstTime){
								//������ʱ����ֵ
								isNext = true;
								isFirstTime = false;
								//����ϴν�Ҫ��ʾ��ҳ��
								if(activePage){
									activePage.classList.remove('z-active');
									activePage.classList.remove('z-move');
								}
								//��ȡ��ǰ��Ҫ��ʾ����һҳ
								if(currentPage.nextElementSibling && currentPage.nextElementSibling.classList.contains('page')) {
									activePage =  currentPage.nextElementSibling;
								} else {
									activePage =  theClass._$pages.first().get(0);
									triggerLoop = true;
								}
								if(activePage && activePage.classList.contains('page')){
									//��ȡ�ɹ�����ʼ����һҳ
									activePage.classList.add('z-active');
									activePage.classList.add('z-move');
									activePage.style.webkitTransition = 'none';
									activePage.style.webkitTransform = 'translateY('+window.innerHeight+'px)';
									$(activePage).trigger('active');
									currentPage.style.webkitTransformOrigin = 'top center';
								}else{
									//��ȡʧ�ܣ����õ�ǰҳ
									currentPage.style.webkitTransform = 'translateY(0px) scale(1)';
									activePage = null;
								}
							}else{
								//�ƶ�ʱ������ʽ
								currentPage.style.webkitTransform = 'scale('+ ((window.innerHeight + moveDistanceY) / window.innerHeight).toFixed(3) +')';
								activePage.style.webkitTransform = 'translateY('+ (window.innerHeight + moveDistanceY) +'px)';
							}
						}
					}
				}
			}).on('mouseup touchend', function (e) {
				if(isStart){
					//������ʱ����
					isStart = false;
					if(activePage){
						theClass._isDisableFlipPage = true;
						//����ת������
						currentPage.style.webkitTransition = '-webkit-transform 0.4s ease-out';
						activePage.style.webkitTransition = '-webkit-transform 0.4s ease-out';
						//�ж��ƶ������Ƿ񳬹�100
						if(Math.abs(moveDistanceY) > Math.abs(moveDistanceX) && Math.abs(moveDistanceY) > 100){
							//�л��ɹ������õ�ǰҳ�涯��
							if(isNext){
								currentPage.style.webkitTransform = 'scale(0.2)';
								activePage.style.webkitTransform = 'translateY(0px)';
							}else{
								currentPage.style.webkitTransform = 'scale(0.2)';
								activePage.style.webkitTransform = 'translateY(0px)';
							}
							//ҳ�涯��������ɺ���
							setTimeout(function () {
								activePage.classList.remove('z-active');
								activePage.classList.remove('z-move');
								activePage.classList.add('z-current');
								currentPage.classList.remove('z-current');
								currentPage.classList.remove('z-move');
								theClass._isDisableFlipPage = false;
								//���浱ǰҳ�棬������ҳ���¼�
								theClass.$currentPage = $(activePage).trigger('current');
								$(currentPage).trigger('hide');
							},500);
						}else{
							//�л�ȡ�������õ�ǰҳ�涯��
							if(isNext){
								currentPage.style.webkitTransform = 'scale(1)';
								activePage.style.webkitTransform = 'translateY(100%)';
							}else{
								currentPage.style.webkitTransform = 'scale(1)';
								activePage.style.webkitTransform = 'translateY(-100%)';
							}
							//ҳ�涯��������ɺ���
							setTimeout(function () {
								activePage.classList.remove('z-active');
								activePage.classList.remove('z-move');
								theClass._isDisableFlipPage = false;
							},500);
						}
					}else{
						currentPage.classList.remove('z-move');
					}
				}
			});
		});

		//Ϊ�����ҳ��ҳ������������
		$win.on('load', function (e) {
			var guideHtml ='<div class="u-guideWrap"><a href="javascript:void(0);" class="u-guideTop z-move"></a></div>';
			theClass._$pages.not(theClass._$pages.last()).append(guideHtml);
		});

		//��ʼ��Loading���
		$win.on('load', function (e) {
			//��ȡ����
			var $appLoading = $('#app-loading');
			//��������/�Ƴ�
			$appLoading.addClass('z-hide');
			$appLoading.on('webkitTransitionEnd', function (e) {
				$appLoading.remove();
			});

			//ָʾ��ʼ�����
			theClass._isInitComplete = true;
			//��ʾ��һ��ҳ��
			theClass.showPage();
		});
	};

	//��ʾҳ��
	App.prototype.showPage = function(page) {
		var theClass = this;
		//��ȡ����
		window._app_showPage ? window._app_showPage : window._app_showPage = function (page) {
			//�ҵ�Ҫ��ʾ��ҳ��
			var type = typeof(page);
			var $page;
			switch(type){
				case 'number':
					$page = this._$pages.eq(page);
				break;
				case 'string':
					$page = this._$pages.filter(page).first();
				break;
				case 'object':
					$page = $(page);
				break;
			}
			//�ж��Ƿ�Ϊ��һ����ʾҳ�沢��û��ҳ���������ǰҳ��Ϊ��һ��ҳ��
			if(this._isFirstShowPage && (!$page || !$page.length)){
				$page = this.$currentPage;
				this._isFirstShowPage = false;
			}
			//�����������ʾ��ǰҳ��
			if($page && $page.length){
				this._$pages.filter('.z-current').removeClass('z-current');
				$page.css('-webkit-transform', 'none').addClass('z-current');
				$page.trigger('current');
				this.$currentPage = $page;
			}
		};

		//�����ʼ�������
		if(this._isInitComplete){
			//ֱ�ӵ���
			window._app_showPage.apply(theClass, [page]);
		}else{
			//�ȼ�����ɺ��ٵ���
			$(window).one('load', function () {
				window._app_showPage.apply(theClass, [page]);
			});
		}
	};

	//���÷�ҳ
	App.prototype.disableFlipPage = function () {
		//���ý�ֹ��ҳ����ֵ
		this._isDisableFlipPage = true;
	};

	//���÷�ҳ
	App.prototype.enableFlipPage = function () {
		//���ý�ֹ��ҳ����ֵ
		this._isDisableFlipPage = false;
	};

	//���÷�ҳģʽ��mode��0:���÷�ҳ��1:�������·�ҳ��2:���������Ϸ�ҳ��3:���������·�ҳ��
	App.prototype.setFlipPageMode = function (mode) {
		if(typeof(mode) != 'number' || mode < 0 || mode > 3){
			throw 'App.setFlipPageMode �������ô������ṩ������ȷ�Ĳ�����0:���÷�ҳ��1:�������·�ҳ��2:���������Ϸ�ҳ��3:���������·�ҳ��';
		}
		//���ý�ֹ��ҳ��ر���ֵ
		switch(mode){
			case 0:
				this._isDisableFlipPage = true;
				this._isDisableFlipPrevPage = true;
				this._isDisableFlipNextPage = true;
			break;
			case 1:
				this._isDisableFlipPage = false;
				this._isDisableFlipPrevPage = false;
				this._isDisableFlipNextPage = false;
			break;
			case 2:
				this._isDisableFlipPage = false;
				this._isDisableFlipPrevPage = false;
				this._isDisableFlipNextPage = true;
			break;
			case 3:
				this._isDisableFlipPage = false;
				this._isDisableFlipPrevPage = true;
				this._isDisableFlipNextPage = false;
			break;
		}
	};

	//����app����
	var app = new App( $('body') );

	//�����ṩapp����ӿ�
	module.exports = app;
});