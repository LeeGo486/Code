(function() {
	//global name space for home page
	home = {};
	$.extend(home, {
		initialize: function() {
			var elegantContent =
			"<h4 style='margin:0 0 5px 0;padding:0.2em 0'>雅莹女装</h4>" + 
			"<img style='float:right;margin:4px' id='imgDemo' src='http://www.elegant-prosper.com/img/front/logo_login.gif' width='152' height='94' title='雅莹女装'/>" + 
			"<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>雅莹女装坐落在中国嘉兴市华云路,320国道南侧,与石臼漾生态公园相望,是嘉兴市创新企业的龙头示范单位...</p>" + 
			"</div>";
			
			var msfeContent =
			"<h4 style='margin:0 0 5px 0;padding:0.2em 0'>马斯菲尔女装</h4>" + 
			"<img style='float:right;margin:4px' id='imgDemo' src='http://imgsrc.baidu.com/baike/abpic/item/9f6e1908480dbb64e92488af.jpg' width='150' height='150' title='马斯菲尔女装'/>" + 
			"<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>马斯菲尔女装坐落在中国深圳市,Marisfrolg女装汲取欧洲时尚元素， 秉承经典、优雅的服饰理念，巧妙地运用色彩的搭配和自然的剪裁，展现女性简约、温婉的特质。其“成熟中散发青春魅力、优雅中蕴涵时尚气息”的独特时装文化，吸引着越来越多崇尚完美的现代女性。产品系列包括高级女装、手袋、配饰、鞋靴等...</p>" + 
			"</div>";
			
			var gdContent =
			"<h4 style='margin:0 0 5px 0;padding:0.2em 0'>哥弟女装</h4>" + 
			"<img style='float:right;margin:4px' id='imgDemo' src='http://imgsrc.baidu.com/baike/abpic/item/d8b8c92a548b227ed52af102.jpg' width='150' height='100' title='哥弟女装'/>" + 
			"<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>源自中国台湾，创始于公元1977年，本着将心比心、相辅相成的团队观，秉持物有所值、物超所值的诚信经营理念。乐观的、坚毅的、责任的，期望打造出一个不断创造工作机会，回馈社会，有信、有望、有爱的企业。哥弟四海，四海哥弟，诠释的是大和合，共容共荣，跨越主观，无远弗届，阐明思维主导行为，决定未来...</p>" + 
			"</div>";

			var map = new BMap.Map("mapContainer");
			// 创建Map实例
			var point1 = new BMap.Point(110.50, 33);
			var elegant = new BMap.Point(120.70, 30.7);
			var elegantmarker = new BMap.Marker(elegant);
			var elegantinfoWindow = new BMap.InfoWindow(elegantContent);
			// 创建信息窗口对象

			var msfe = new BMap.Point(114.056, 22.535);
			var msfemarker = new BMap.Marker(msfe);
			var msfeinfoWindow = new BMap.InfoWindow(msfeContent);
			// 创建信息窗口对象

			var gd = new BMap.Point(121.056, 23.55);
			var gdmarker = new BMap.Marker(gd);
			var gdinfoWindow = new BMap.InfoWindow(gdContent);
			// 创建信息窗口对象

			map.centerAndZoom(point1, 5);

			map.enableScrollWheelZoom();
			// 启用滚轮放大缩小。

			map.enableKeyboard();
			// 启用键盘操作。

			map.addControl(new BMap.NavigationControl());
			// 添加鱼骨工具条

			map.addOverlay(elegantmarker);
			map.addOverlay(msfemarker);
			map.addOverlay(gdmarker);

			elegantmarker.addEventListener("click", function() {
				this.openInfoWindow(elegantinfoWindow);
				//图片加载完毕重绘infowindow
				document.getElementById('imgDemo').onload = function() {
					elegantinfoWindow.redraw();
				}
			});

			msfemarker.addEventListener("click", function() {
				this.openInfoWindow(msfeinfoWindow);
				//图片加载完毕重绘infowindow
				document.getElementById('imgDemo').onload = function() {
					msfeinfoWindow.redraw();
				}
			});

			gdmarker.addEventListener("click", function() {
				this.openInfoWindow(gdinfoWindow);
				//图片加载完毕重绘infowindow
				document.getElementById('imgDemo').onload = function() {
					gdinfoWindow.redraw();
				}
			}); 

		}
	})
})();
