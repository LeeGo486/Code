using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using System.Data;
using System.Xml;
using System.Xml.Xsl;
using System.Configuration;
using System.Data.SqlClient;

public partial class Storage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void Shops_DataBind(object sender, StoreRefreshDataEventArgs e)
    {
        string condition = Server.HtmlEncode(TxtSearch.Text.Trim().Replace("'", ""));
        if (condition.Trim().Length > 0)
            condition = " depotid like '%" + condition + "%' or d_name like '%" + condition + "%'";
        e.Total = int.Parse(GetTotalCount(condition));
        Shops_MainStore.DataSource = GetShops(e.Limit.ToString(), e.Start.ToString(), condition);
        Shops_MainStore.DataBind();
    }
    protected void NodeLoad(object sender, NodeLoadEventArgs e)
    {
        if (!string.IsNullOrEmpty(e.NodeID))
        {
            System.Data.DataTable dtroot = new DataTable();
            if (e.NodeID == "0")
                dtroot = GetFather(e.NodeID);
            else
                dtroot = GetTree(e.NodeID);
            foreach (System.Data.DataRow dr in dtroot.Rows)
            {
                //核心
                if (dr["isleaf"].ToString().Trim() == "0")
                {
                    AsyncTreeNode asyncNode = new AsyncTreeNode();
                    asyncNode.Text = dr["name"].ToString().Trim();
                    asyncNode.NodeID = dr["structid"].ToString().Trim();
                    asyncNode.SingleClickExpand = true;
                    asyncNode.Checked = ThreeStateBool.False;
                    e.Nodes.Add(asyncNode);
                }
                else
                {
                    Ext.Net.TreeNode treeNode = new Ext.Net.TreeNode();
                    treeNode.Text = dr["name"].ToString().Trim();
                    treeNode.NodeID = dr["structid"].ToString().Trim();
                    treeNode.Leaf = true;
                    treeNode.Qtip = dr["structid"].ToString().Trim() + "_" + dr["name"].ToString().Trim();
                    treeNode.Checked = ThreeStateBool.False;
                    treeNode.Icon = Icon.ControlBlankBlue;
                    e.Nodes.Add(treeNode);
                }
            }
        }
    }
    [DirectMethod]
    public void BtnSearch_Report(string type)
    {
        try
        {
            string jg = TxtSelectedName.Text.Trim();
            string shops = TxtShops.Text.Trim();
            if (shops.Length <= 0 || jg.Length <= 0)
            {
                X.Msg.Alert("警告", "请先选择虚拟结构和店铺！").Show();
                return;
            }
            string[] xnjg = jg.Split(';');
            string constructid = "";
            foreach (string a in xnjg)
            {
                if (a.Contains("_"))
                    constructid += a.Substring(0, a.IndexOf('_')) + ",";
            }
            string[] shopid = shops.Split(';');
            string conshops = "";
            foreach (string a in shopid)
            {
                if (a.Contains("_"))
                    conshops += "'" + a.Substring(0, a.IndexOf('_')) + "',";
            }
            if (type == "GridMain")
            {
                ReportStore.DataSource = GetReport_DQ(conshops.TrimEnd(','), constructid.TrimEnd(','));
                ReportStore.DataBind();
            }
            else if (type == "CJKPGrid")
            {
                KPStore.DataSource = GetReport_KP(conshops.TrimEnd(','), constructid.TrimEnd(','));
                KPStore.DataBind();
            }
            else if (type == "NoDPDQGrid")
            {
                NoDPDQStore.DataSource = GetReport_NoDPDQ(conshops.TrimEnd(','), constructid.TrimEnd(','));
                NoDPDQStore.DataBind();
            }
            else if (type == "NoDPKPGrid")
            {
                NoDPKPStore.DataSource = GetReport_NoDPKP(conshops.TrimEnd(','), constructid.TrimEnd(','));
                NoDPKPStore.DataBind();
            }
        }
        catch (Exception error)
        {
            X.Msg.Alert("异常", error.Message).Show();
        }
    }
    protected void GetExamplesNodes(object sender, NodeLoadEventArgs e)
    {
        if (e.NodeID == "0")
        {
            e.Nodes = GetAMMenu();
        }
    }
    public Ext.Net.TreeNodeCollection GetAMMenu()
    {
        DataTable dtroot = GetFather("0");
        return CreateAMTree(dtroot);
    }
    private Ext.Net.TreeNodeCollection CreateAMTree(DataTable dt)
    {
        Ext.Net.TreeNodeCollection nodes = new Ext.Net.TreeNodeCollection(false);
        foreach (System.Data.DataRow dr in dt.Rows)
        {
            Ext.Net.TreeNode node = new Ext.Net.TreeNode();
            //核心
            if (dr["isleaf"].ToString().Trim() == "0")
            {
                node.Text = dr["name"].ToString().Trim();
                node.NodeID = dr["structid"].ToString().Trim();
                node.SingleClickExpand = true;
                node.Checked = ThreeStateBool.False;
                DataTable dtfather = GetTree(dr["structid"].ToString());
                node.Nodes.AddRange(CreateAMTree(dtfather));
            }
            else
            {
                node.Text = dr["name"].ToString().Trim();
                node.NodeID = dr["structid"].ToString().Trim();
                node.Leaf = true;
                node.Qtip = dr["parentid"].ToString().Trim() + "_" + dr["structid"].ToString().Trim() + "|" + dr["name"].ToString().Trim();
                node.Checked = ThreeStateBool.False;
                node.Icon = Icon.ControlBlankBlue;

            }
            nodes.Add(node);
        }
        return nodes;
    }

    protected void BtnSaveToExcel(object sender, EventArgs e)
    {
        string json = ExcelGridData.Value.ToString();
        json = json.Replace("d_name", "店铺");
        json = json.Replace("name4", "虚拟结构");
        json = json.Replace("name5", "虚拟结构");
        json = json.Replace("styleid", "款号");
        json = json.Replace("colorid", "颜色");
        json = json.Replace("s2s", "2");
        json = json.Replace("s3s", "3");
        json = json.Replace("s4s", "4");
        json = json.Replace("s5s", "5");
        json = json.Replace("s6s", "6");
        json = json.Replace("total", "合计");
        StoreSubmitDataEventArgs eSubmit = new StoreSubmitDataEventArgs(json, null);
        XmlNode xml = eSubmit.Xml;
        this.Response.Clear();
        this.Response.ContentType = "application/vnd.ms-excel";
        this.Response.AddHeader("Content-Disposition", "attachment; filename=Report.xls");
        XslCompiledTransform xtExcel = new XslCompiledTransform();
        xtExcel.Load(Server.MapPath("ExcelTemp/Excel.xsl"));
        xtExcel.Transform(xml, null, this.Response.OutputStream);
        this.Response.End();
    }


    #region
    private DataTable Query(string SQLString)
    {
        //using (SqlConnection connection = new SqlConnection(DBPWDHelper.GetDBPwd.GetDBConString_MSSQL(ConfigurationManager.AppSettings["AuthKey102AS"], "002", "EP_DRP_AS", "PROD")))
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.AppSettings["F22AS"]))
        {
            DataSet ds = new DataSet();
            try
            {
                connection.Open();
                SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                command.Fill(ds, "ds");
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception(ex.Message);
            }
            return ds.Tables[0];
        }
    }

    private DataTable GetShops(string limit, string start, string conditions)
    {
        string sql = "select top " + limit + " * from V_J_DEPOT_ChenJie where id <( select isnull(MIN(id),(select max(id)+1 from V_J_DEPOT_ChenJie)) from (select top " + start + " id from V_J_DEPOT_ChenJie order by id desc) as Temp ) order by id desc";
        if (conditions.Trim().Length > 0)
        {
            sql = "select top " + limit + " * from V_J_DEPOT_ChenJie where id <( select isnull(MIN(id),(select max(id)+1 from V_J_DEPOT_ChenJie)) from (select top " + start + " id from V_J_DEPOT_ChenJie  where " + conditions + " order by id desc) as Temp ) and (" + conditions + ") order by id desc";
        }
        return Query(sql);
    }
    private string GetTotalCount(string conditions)
    {
        string sql = "select count(*) from v_j_depot";
        if (conditions.Trim().Length > 0)
            sql += " where " + conditions;
        try
        {
            return Query(sql).Rows[0][0].ToString();
        }
        catch
        {
            return "0";
        }
    }
    private DataTable GetFather(string fatherid)
    {
        string sql = "select parentid,structid,name,'0' as isleaf from Y_DHTOPF_KSDG_RECORD where parentid={0}";
        return Query(string.Format(sql, fatherid));
    }
    private DataTable GetTree(string id)
    {
        string sql = "select parentid,structid,name,case when (name5 is null) then '0' else '1' end as isleaf from Y_DHTOPF_KSDG_RECORD where parentid={0}";
        return Query(string.Format(sql, id));
    }

    private DataTable GetReport_DQ(string conshops, string structids)
    {
        string sql = " with temp as( "
                    + " select d.d_name,jg.name4,jg.name5,st.styleid,st.colorid,st.sizeid,st.k_num from v_j_depot d,v_j_stock st,("
                    + " select v.structid,v.name4,v.name5,s.styleid from dbo.V_J_COLORSTRUCT v, V_J_COLORSTRUCTSUB s"
                    + " where v.structid=s.structid) as jg"
                    + " where st.styleid=jg.styleid and d.depotid=st.depotid"
                    + " and d.depotid in ({0}) and jg.structid in ({1})"
                    + " )"
                    + " select d_name,name4,name5,styleid,colorid,"
                    + " SUM(case sizeid when 'F' then k_num end) as F,"
                    + " SUM(case sizeid when '2' then k_num end) as [s2s],"
                    + " SUM(case sizeid when '3' then k_num end) as [s3s],"
                    + " SUM(case sizeid when '4' then k_num end) as [s4s],"
                    + " SUM(case sizeid when '5' then k_num end) as [s5s],"
                    + " SUM(case sizeid when '6' then k_num end) as [s6s],"
                    + " sum(k_num) as total"
                    + " from temp"
                    + " group by d_name,name4,name5,styleid,colorid";
        return Query(string.Format(sql, conshops, structids));
    }

    private DataTable GetReport_KP(string conshops, string structids)
    {
        string sql = " with temp as( "
                    + " select d.d_name,jg.name4,jg.name5,st.styleid,st.colorid,st.sizeid,st.p_num from v_j_depot d,v_j_stock st,("
                    + " select v.structid,v.name4,v.name5,s.styleid from dbo.V_J_COLORSTRUCT v, V_J_COLORSTRUCTSUB s"
                    + " where v.structid=s.structid) as jg"
                    + " where st.styleid=jg.styleid and d.depotid=st.depotid"
                    + " and d.depotid in ({0}) and jg.structid in ({1})"
                    + " )"
                    + " select d_name,name4,name5,styleid,colorid,"
                    + " SUM(case sizeid when 'F' then p_num end) as F,"
                    + " SUM(case sizeid when '2' then p_num end) as [s2s],"
                    + " SUM(case sizeid when '3' then p_num end) as [s3s],"
                    + " SUM(case sizeid when '4' then p_num end) as [s4s],"
                    + " SUM(case sizeid when '5' then p_num end) as [s5s],"
                    + " SUM(case sizeid when '6' then p_num end) as [s6s],"
                    + " sum(p_num) as total"
                    + " from temp"
                    + " group by d_name,name4,name5,styleid,colorid";
        return Query(string.Format(sql, conshops, structids));
    }

    private DataTable GetReport_NoDPDQ(string conshops, string structids)
    {
        string sql = " with temp as( "
                    + " select jg.name4,jg.name5,st.styleid,st.colorid,st.sizeid,st.k_num from v_j_depot d,v_j_stock st,("
                    + " select v.structid,v.name4,v.name5,s.styleid from dbo.V_J_COLORSTRUCT v, V_J_COLORSTRUCTSUB s"
                    + " where v.structid=s.structid) as jg"
                    + " where st.styleid=jg.styleid and d.depotid=st.depotid"
                    + " and d.depotid in ({0}) and jg.structid in ({1})"
                    + " )"
                    + " select name4,name5,styleid,colorid,"
                    + " SUM(case sizeid when 'F' then k_num end) as F,"
                    + " SUM(case sizeid when '2' then k_num end) as [s2s],"
                    + " SUM(case sizeid when '3' then k_num end) as [s3s],"
                    + " SUM(case sizeid when '4' then k_num end) as [s4s],"
                    + " SUM(case sizeid when '5' then k_num end) as [s5s],"
                    + " SUM(case sizeid when '6' then k_num end) as [s6s],"
                    + " sum(k_num) as total"
                    + " from temp"
                    + " group by name4,name5,styleid,colorid";
        return Query(string.Format(sql, conshops, structids));
    }

    private DataTable GetReport_NoDPKP(string conshops, string structids)
    {
        string sql = " with temp as( "
                    + " select jg.name4,jg.name5,st.styleid,st.colorid,st.sizeid,st.p_num from v_j_depot d,v_j_stock st,("
                    + " select v.structid,v.name4,v.name5,s.styleid from dbo.V_J_COLORSTRUCT v, V_J_COLORSTRUCTSUB s"
                    + " where v.structid=s.structid) as jg"
                    + " where st.styleid=jg.styleid and d.depotid=st.depotid"
                    + " and d.depotid in ({0}) and jg.structid in ({1})"
                    + " )"
                    + " select name4,name5,styleid,colorid,"
                    + " SUM(case sizeid when 'F' then p_num end) as F,"
                    + " SUM(case sizeid when '2' then p_num end) as [s2s],"
                    + " SUM(case sizeid when '3' then p_num end) as [s3s],"
                    + " SUM(case sizeid when '4' then p_num end) as [s4s],"
                    + " SUM(case sizeid when '5' then p_num end) as [s5s],"
                    + " SUM(case sizeid when '6' then p_num end) as [s6s],"
                    + " sum(p_num) as total"
                    + " from temp"
                    + " group by name4,name5,styleid,colorid";
        return Query(string.Format(sql, conshops, structids));
    }
    #endregion
}