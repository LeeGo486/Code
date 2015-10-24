using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ServiceProcess;

namespace LYMsgInterfaceApp
{
    class LogicHandle
    {
        //filed

        //Method

        #region 获取数据
        internal DataTable GetDataView(string _sql)
        {

            DataTable dtRst = new DataTable();

            DbHandle DbH = new DbHandle();

            return dtRst = DbH.GetData(_sql);
        }
        #endregion

        #region 插入数据
        internal bool Insert
            (string _tableName, List<string> _field, List<string> _value)
        {
            bool bRst = false;

            DbHandle dbH = new DbHandle();

            bRst = dbH.Insert(_tableName, _field, _value);

            return bRst;
        }
        #endregion

        #region 获取行数
        internal int GetCount(string _tabName, string _where)
        {
            int iRst = 0;

            DbHandle dbH = new DbHandle();

            iRst = dbH.GetCount(_tabName, _where);

            return iRst;
        }
        #endregion
        
        #region 更新单字段数据
        internal bool Update(string _tabName, string _where)
        {
            bool bRst = false;

            DbHandle dbH = new DbHandle();

            bRst = dbH.Update(_tabName, _where);

            return bRst;
        }
        #endregion

        #region 更新多字段数据
        internal bool UpdateMany
            (string _tabName, List<string> _field, List<string> _value, string _where)
        {
            bool bRst = false;

            DbHandle dbH = new DbHandle();

            bRst = dbH.UpdateMany(_tabName, _field, _value, _where);

            return bRst;
        }
        #endregion

        #region 服务的方法

        #region 获取服务
        internal ServiceController GetServiceObject()
        {
            return new ServiceController("LYSendMessage");
        }
        #endregion

        #region 重启服务
        internal void ReStarService(ServiceController sc)
        {
            this.StopService(sc);
            this.StarService(sc);
        }
        #endregion

        #region 停止服务

        internal void StopService(ServiceController sc)
        {
            if ((sc.Status == ServiceControllerStatus.Paused) || (sc.Status == ServiceControllerStatus.Running))
            {
                sc.Stop();
            }
        }
        #endregion

        #region 开启服务
        internal void StarService(ServiceController sc)
        {
            if ((sc.Status == ServiceControllerStatus.Paused) || (sc.Status == ServiceControllerStatus.Stopped))
            {
                sc.Start();
            }
        }
        #endregion

        #endregion
    }
       

        


}
