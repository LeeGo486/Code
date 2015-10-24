var m_selected;

$(function () {
    InitGird();
})

function InitGird() {

    $('#tab_list').datagrid(
        {
            title: '������Ա�б�', //������
            url: GetWSRRURL('D8640684-505A-69EA-6572-2BBA43C3CE13'),        
            queryParams: { "XML": GetGetJson() },
            sortable: true,
            width: '90%', //���
            height: $(document).height() - 25, //�߶�
            nowrap: true, //�Ƿ��У�True �ͻ��������ʾ��һ����
            remoteSort: true, //�����Ƿ�ӷ���������������
            collapsible: false, //���۵�
            striped: true, //True ��ż��ʹ�ò�ͬ����ɫ
            singleSelect: true, //����ѡ��
            //fit: true,
            pagination: true, //�Ƿ�����ҳ
            pageSize: 20, //Ĭ��һҳ��������
            onSelect: function () { m_selected = $('#tab_list').datagrid('getSelected'); GetAuthorizationValue(); },
            columns: [[
	            { field: 'userid', title: '�û�ID', width: 100, search: true, sortable: true },
                { field: 'username', title: '�û�����', width: 100, search: true, sortable: true },
            ]],
            onLoadSuccess: function () { $('#tab_list').datagrid('selectRow', 0); }
        });
}

function GetAuthorizationValue() {
    
    if (m_selected) {
        $("#tree_Menu").tree({
            url: GetTreeWSRRURL('E1D92923-8A3C-1034-B63E-8B627852C34F', "HavaFlag") + "&XML=" + GetGetJson([{ "username": m_selected.username }]),
            checkbox: true
        })
    }

}

function Authorization_Submit() {

    if (m_selected == undefined) {
        return false;
    }
    var nodes = $('#tree_Menu').tree('getChecked');
    var s = '';
    for (var i = 0; i < nodes.length; i++) {
        if (s != '') s += ',';
        s += nodes[i].id;
    }
    $('#txtform_AuthorizationSubmit_AUZlist').val(s);
    //$('#txtform_AuthorizationSubmit_VexSSONewID').val(m_selected.vexssonewid);
    $('#txtform_AuthorizationSubmit_App_UserID').val(m_selected.userid);
    $('#txtEnv_ID').val($('#txtEnv_IDShow').combobox('getValue'));

    var data = $('#form_AuthorizationSubmit').serializeArray();
    var XMLData = GetFormJson(data, 'UPDATE');
    $.messager.progress({ title: '���Ժ�', msg: '������' });
    $.ajax({
        url: GetWSRRURL('E1D92923-8A3C-1034-B63E-8B627852C34F'),
        type: 'post',
        async: true, //�첽,
        data: { "XML": XMLData },
        success: function (result) {
            try {
                var result = eval("[" + result + "]");

                if (result[0].Error) {
                    $.messager.progress('close');

                    $.messager.alert("ϵͳ����", result[0].Error, 'error');
                } else if (result[0].rows[0].result == "False") {
                    $.messager.progress('close');

                    $.messager.alert("��ʾ", result[0].rows[0].message, 'error');
                }
                else {
                    $.messager.progress('close');
                    $('#tab_list').datagrid("unselectAll");
                    $('#tab_list').datagrid("reload");

                    $.messager.alert("��ʾ", result[0].rows[0].message);
                }
            } catch (ex) {
                $.messager.progress('close');

                $.messager.alert("��ʾ", ex, 'error');
            }
        },
        error: function () {
            $.messager.alert("��ʾ", "�ύ�����ˣ�", 'error');
        }
    });
}