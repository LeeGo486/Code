<%@ control language="C#" autoeventwireup="true" inherits="branch_Controls_MultiSelector, App_Web_multiselector.ascx.25b9497d" %>

<script type="text/javascript">

    function moveTo(from, to, all, key) {
        to.find('option:selected').removeAttr('selected');
        if (key) {
            var start = $("#start").val()|| 0;
            var len = key.length;

            //o 表原来方式筛选
            if (parseInt(start) == "0") {
                from.find(all ? 'option' : key ? 'option[text*=' + key.toUpperCase() + ']' : 'option:selected').prependTo(to);
            } else {
                start = start - 1;
                key = key.toUpperCase();

                $.each(from.find("option"), function (i, o) {
                    if (o.value.substr(start, len).toUpperCase() == key)
                        $(o).prependTo(to);
                });
            }

        }else if (all) {
            from.find('option').prependTo(to);
        } else {
            from.find('option:selected').prependTo(to);
        }

        writecount();
    }

    function writecount() {
        $('#<%=this.ClientID %> #lcount').text(tf($('select:eq(0) option').length))
        $('#<%=this.ClientID %> #rcount').text(tf($('select:eq(1) option').length))
    }
    function tf(str) {
        return '共：' + str + '条';
    }

    $(function() {
        $('form').submit(function() { return false; })
        var left = $('#<%=this.ClientID %> select:eq(0)');
        var right = $('#<%=this.ClientID %> select:eq(1)');
        $('#<%=this.ClientID %> :button:eq(0)').click(function() { moveTo(left, right); });
        $('#<%=this.ClientID %> :button:eq(1)').click(function() { moveTo(right, left); });
        $('#<%=this.ClientID %> :button:eq(2)').click(function() { moveTo(left, right, true); });
        $('#<%=this.ClientID %> :button:eq(3)').click(function() { moveTo(right, left, true); });

        left.dblclick(function() { moveTo(left, right); });
        right.dblclick(function() { moveTo(right, left); });

        $('#<%=this.ClientID %> #leftkey').bind('keydown', 'return', function() {
            var key = $.trim($(this).val());
            if (!key) return;
            moveTo(left, right, false, key);
            $(this).val('').focus();
        });

        $('#<%=this.ClientID %> #rightkey').bind('keydown', 'return', function() {
            var key = $.trim($(this).val());
            if (!key) return;
            moveTo(right, left, false, key);
            $(this).val('').focus();
        });

        writecount();
    });

</script>

<div id="<%=this.ClientID %>">
<table style="width: 100%;" cellpadding="0" cellspacing="5">
    <tr>
        <td>
            <span id="lcount" style="float: right;"></span><b>未选中</b>
        </td>
        <td>
        </td>
        <td>
            <span id="rcount" style="float: right;"></span><b>已选中</b>
        </td>
    </tr>
    <tr>
        <td rowspan="6">
           <select size="20" name="LeftSelector" multiple="multiple" id="LeftSelector" style="width: 230px;">
                <% foreach (System.Data.DataRow dr in this.DataSource.Select(string.Format("{0}=0", this.SelectKeyField))) 
                   { 
                       %><option value="<%=dr[this.DataValueField].ToString().ToUpper() %>"><%=dr[this.DataTextField] %></option><%
                   } %>
            </select>
        </td>
        <td style="width: 60px;">
            &nbsp;
        </td>
        <td rowspan="6">
            <select size="20" name="RightSelector" multiple="multiple" id="RightSelector" style="width: 230px;">
                <% foreach (System.Data.DataRow dr in this.DataSource.Select(string.Format("{0}=1", this.SelectKeyField)))
                   { 
                       %><option value="<%=dr[this.DataValueField].ToString().ToUpper() %>"><%=dr[this.DataTextField] %></option><%
                   } %>
            </select>
        </td>
    </tr>
    <tr>
        <td>
            <input id="add" type="button" value="&gt;" style="width: 60px;" />
        </td>
    </tr>
    <tr>
        <td>
            <input id="remove" type="button" value="&lt;" style="width: 60px;" />
        </td>
    </tr>
    <tr>
        <td>
            <input id="addall" type="button" value="&gt;&gt;" style="width: 60px;" />
        </td>
    </tr>
    <tr>
        <td>
            <input id="removeall" type="button" value="&lt;&lt;" style="width: 60px;" />
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            加入指定记录：
            <input type="text" id="leftkey" />
        </td>
        <td>
            从<input type="text" id="start" maxlength="2" value="0"  style="width: 16px;margin:1px;" title='0表示模糊匹配,否则从指定位开始匹配'  />匹配
        </td>
        <td>
            移出指定记录：
            <input type="text" id="rightkey" />
        </td>
    </tr>
</table>
</div>