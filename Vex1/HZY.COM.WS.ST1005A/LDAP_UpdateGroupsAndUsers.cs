using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.DirectoryServices;
using System.DirectoryServices.Protocols;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.ST1005A
{
    /// <summary>
    ///LDAP_UpdateGroupsAndUsers 将小翅膀的信息更新到LDAP的服务上
    /// </summary>
    public class LDAP_UpdateGroupsAndUsers : LogicBase, ILogicExecute
    {
        public LDAP_UpdateGroupsAndUsers()
        {
            this.m_SessionCheck = false;


        }

        private Common.LdapConnect ldap;
        Dbconn conn_MDM;

        public bool Execute()
        {
            try
            {
                conn_MDM = new Dbconn("MDM");
                DataTable dt_user = conn_MDM.GetDataTable(@"
            SELECT DISTINCT AM_login FROM dbo.AM_User t1 WITH(NOLOCK)
            JOIN dbo.AM_User_Dept t2 WITH(NOLOCK) ON t1.AM_User_id = t2.AM_USER_ID
            JOIN dbo.AM_Dept t3 WITH(NOLOCK) ON t2.AM_S_Dept_ID = t3.AM_S_Dept_ID
            WHERE  AM_Company='235'
    ", new string[0]);

                //目前只更新雅莹的数据
                ldap = new Common.LdapConnect("192.168.0.171:389", "cn=root", "elegant.admin");
                ldap = new Common.LdapConnect("172.16.205.73:389", "cn=root", "elegant");
                ldap.TargetOU = "dc=hwayifashiongroup,dc=com";
                ldap.TargetOU = "dc=elegant-prosper,dc=com,dc=cn";


                if (!ldap.ConnectLDAP())
                {
                    return false;
                }
                for (int i = 0; i < dt_user.Rows.Count; i++)
                {
                    string strUser = dt_user.Rows[i]["AM_login"].ToString();

                    DirectoryAttribute[] dir = new DirectoryAttribute[4];
                    dir[0] = new DirectoryAttribute("cn", strUser);
                    dir[1] = new DirectoryAttribute("sn", strUser);
                    dir[2] = new DirectoryAttribute("objectClass", "inetOrgPerson");
                    dir[3] = new DirectoryAttribute("userPassword", "111111");
                    ldap.LadpAdd("uid=" + strUser + ",ou=peoples", dir).ToString();
                }

                //取二级部门是室和部结尾的所有雅莹的数据
                DataTable dt_Groups = conn_MDM.GetDataTable(@"
                    SELECT  t3.AM_S_dept_ID,
		                    t3.AM_Dept_Name_All,
                            t3.AM_Dept_Name
                    FROM    dbo.AM_Dept t3
                            LEFT JOIN dbo.AM_Dept t4 WITH ( NOLOCK ) ON t3.AM_Dept1_ID = t4.AM_S_Dept_ID
                    WHERE   t3.AM_Company = '235'
                            AND ( t4.AM_Dept1_ID IS NULL
                                  OR t4.AM_Dept_NAME LIKE '%室'
                                  OR t4.AM_Dept_NAME LIKE '%部'
                                )
                      ORDER BY t3.OrderIndex 
                    ", new string[0]);


                for (int i = 0; i < dt_Groups.Rows.Count; i++)
                {
                    //添加组织架构
                    string strDEPT_Name = dt_Groups.Rows[i]["AM_Dept_Name"].ToString();
                    string strDEPT_Name_All = dt_Groups.Rows[i]["AM_Dept_Name_All"].ToString();

                    string[] strDEPTList = strDEPT_Name_All.Split('\\');

                    string strOU = "";
                    for (int j = strDEPTList.Length-1; j >=0 ; j--)
                    {
                        strOU += "cn="+strDEPTList[j]+",";
                    }

                    strOU += "ou=groups";

                    DirectoryAttribute[] dir = new DirectoryAttribute[2];
                    dir[0] = new DirectoryAttribute("cn", strDEPT_Name);
                    dir[1] = new DirectoryAttribute("objectClass", "container");
                    ldap.LadpAdd(strOU, dir).ToString();
                }


                //组织架构下面的成员
                DataTable dt_Dept_User = conn_MDM.GetDataTable(@"
                    SELECT DISTINCT
                            AM_login ,
                            t3.AM_S_Dept_ID ,
                            t3.AM_p_Dept_ID ,
                            t3.AM_Dept_NAME ,
                            t3.AM_Dept_NAME_All
                    FROM    dbo.AM_User t1 WITH ( NOLOCK )
                            JOIN dbo.AM_User_Dept t2 WITH ( NOLOCK ) ON t1.AM_User_id = t2.AM_USER_ID
                            JOIN dbo.AM_Dept t3 WITH ( NOLOCK ) ON t2.AM_S_Dept_ID = t3.AM_S_Dept_ID
                            LEFT JOIN dbo.AM_Dept t4 WITH ( NOLOCK ) ON t3.AM_Dept1_ID = t4.AM_S_Dept_ID
                    WHERE   t3.AM_Company = '235'
                            AND ( t4.AM_Dept1_ID IS NULL
                                  OR t4.AM_Dept_NAME LIKE '%室'
                                  OR t4.AM_Dept_NAME LIKE '%部'
                                )
                                

            ", new string[0]);


                for (int i = 0; i < dt_Dept_User.Rows.Count; i++)
                {
                    //添加组织架构下的成员
                    string strUser = dt_Dept_User.Rows[i]["AM_login"].ToString();
                    string strDEPT_Name = dt_Dept_User.Rows[i]["AM_Dept_Name"].ToString();
                    string strDEPT_Name_All = dt_Dept_User.Rows[i]["AM_Dept_Name_All"].ToString();

                    //string strOU = "uid=" + strUser + ",cn=" + strDEPT_Name_All.Replace("\\", ",cn=") + ",ou=groups," + ldap.TargetOU;
                    
                    string[] strDEPTList = strDEPT_Name_All.Split('\\');
                    string strOU = "uid=" + strUser + ",";
                    for (int j = strDEPTList.Length - 1; j >= 0; j--)
                    {
                        strOU += "cn=" + strDEPTList[j] + ",";
                    }

                    strOU += "ou=groups";

                    DirectoryAttribute[] dir = new DirectoryAttribute[3];
                    dir[0] = new DirectoryAttribute("cn", strUser);
                    dir[1] = new DirectoryAttribute("sn", strUser);
                    dir[2] = new DirectoryAttribute("objectClass", "inetOrgPerson");
                    ldap.LadpAdd(strOU, dir).ToString();
                }

                return true;

            }
            catch
            {
                throw;
            }
        }

    }
}