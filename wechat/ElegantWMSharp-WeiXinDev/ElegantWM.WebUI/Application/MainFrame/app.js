Ext.onReady(function () {
    Ext.application({
        name: "WMS",
        appFolder: appUrl+"MainFrame",
        autoCreateViewport: true,
        controllers: ['MainFrame'],
        launch: function () {
            var cmp = Ext.getCmp(Cookies.get("ThemeName"));
            if (cmp == null)
                cmp = Ext.getCmp("Skin-Default");
            cmp.setChecked(true);
            if (Ext.get('WMS-loader')) {
                Ext.get('WMS-loader').remove();
            }
        }
    });
});