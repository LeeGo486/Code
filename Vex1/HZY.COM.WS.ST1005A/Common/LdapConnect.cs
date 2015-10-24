using System;
using System.Collections.Generic;
using System.Text;
using System.DirectoryServices;
using System.DirectoryServices.Protocols;
using System.Net;
using System.DirectoryServices;

/// <summary>
///LdapConnect 的摘要说明
/// </summary>
namespace HZY.COM.ST1005A.Common
{
    public class LdapConnect
    {

        public string TargetOU
        {
            get { return m_TargetOU; }
            set { m_TargetOU = value; }
        }

        private LdapConnection m_LdapConnection;
        private string m_LdapServer;
        private NetworkCredential m_Credential;
        //private string m_TargetOU = "dc=elegant-prosper,dc=com,dc=cn";
        private string m_TargetOU = "";
        private string m_UserName;
        private string m_Password;


        public LdapConnect(string ldapServer, string userName, string password, string domainName)
        {
            m_Credential = new NetworkCredential(userName, password, domainName);
            m_LdapServer = ldapServer;
            this.m_UserName = userName;
            this.m_Password = password;


        }
        public LdapConnect(string ldapServer, string userName, string password)
        {
            m_LdapServer = ldapServer;
            m_Credential = new NetworkCredential(userName, password);
            this.m_UserName = userName;
            this.m_Password = password;
        }
        public bool ConnectLDAP()
        {
            m_LdapConnection = new LdapConnection(m_LdapServer);
            m_LdapConnection.SessionOptions.ProtocolVersion = 3;
            m_LdapConnection.AuthType = AuthType.Basic;
            m_LdapConnection.Credential = m_Credential;
            m_LdapConnection.Bind();
            return true;
        }

        public bool LadpAdd(string strOU, DirectoryAttribute[] dirAttrList1)
        {

            string strOU1 = strOU + "," + m_TargetOU;
            AddRequest addRequest = new AddRequest(strOU1, dirAttrList1);
            m_LdapConnection.SendRequest(addRequest);
            return true;
        }


        public SearchResult LdapSearch(string strFilter)
        {

            DirectoryEntry root = new DirectoryEntry("LDAP://" + this.m_LdapServer + "/" + this.m_TargetOU.ToUpper(), this.m_UserName, this.m_Password, AuthenticationTypes.None);

            DirectorySearcher searcher = new DirectorySearcher(root);

            //LDAP搜索的过滤条件,cn为用户名，uid为用户简称
            //searcher.Filter = "(&(objectClass=inetOrgPerson)(|(cn=uid00)(uid=uid00)))";
            searcher.Filter = strFilter;
            SearchResult result = searcher.FindOne();

            return result;
        }
    }
}