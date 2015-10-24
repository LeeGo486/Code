using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;

using HZY.COM.Common.DBAccess;
using HZY.COM.Common;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

public class Service : System.Web.Services.WebService
{
    public Service()
    {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public DataSet HelloWorld()
    {
        Dbconn conn = new Dbconn("MDM");
        DataSet ds = conn.GetDataSet("SELECT * FROM AM_Dept WITH(NOLOCK)");
        return ds;
    }

}