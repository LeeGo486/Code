using System;
using System.Collections.Generic;
using System.Web;
using System.Diagnostics;
using System.Reflection;
using System.Data;
using System.Security.Cryptography;
using System.Collections;
using System.ComponentModel;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml;
using System.Xml.Serialization;
using System.Net;
using HZY.COM.Common;
using HZY.COM.Common.Base;

namespace HZY.COM.Common.WSRRMgr
{

    /// <summary>
    ///Class1 的摘要说明
    /// </summary>
    public class ControlBase
    {
        public ControlBase()
        {

        }

        public HZYmessage hzyMessage = new HZYmessage();

        public bool Excute(string logicName, System.Data.DataSet request)
        {


            bool returnValue = false;
            try
            {
                string strAssemblyName = logicName.Substring(0, logicName.LastIndexOf("."));

                object objInstance = null;
                //objInstance = Activator.CreateInstance(Type.GetType(logicName));

                if (Type.GetType(logicName) != null)
                {
                    objInstance = Activator.CreateInstance(Type.GetType(logicName));
                }
                else
                {
                    objInstance = Activator.CreateInstance(Assembly.Load(strAssemblyName).GetType(logicName));
                }

                if (objInstance is LogicBase)
                {
                    LogicBase logic = (LogicBase)objInstance;

                    if (logic is ILogicExecute)
                    {
                        logic.Request = request;

                        if (logic.SessionCheck)
                        {
                            //用户认证
                            this.hzyMessage = WSRR.CheckUser(hzyMessage.Session_ID,false);
                        }

                        logic.hzyMessage = this.hzyMessage;
                        ILogicExecute iLogic = (ILogicExecute)logic;

                        returnValue = iLogic.Execute();

                        iLogic = null;
                    }
                    else
                    {

                    }

                    logic = null;
                }
                else
                {

                }

                return returnValue;
            }
            catch (Exception ex)
            {
                HZY.COM.Common.Log.WirteLog(ex,"3");
                throw ex;
            }
        }


        public DataSet GetData(string logicName, System.Data.DataSet request)
        {


            DataSet response = null;
            try
            {

                string strAssemblyName = logicName.Substring(0, logicName.LastIndexOf("."));

                object objInstance = null;
                //objInstance = Activator.CreateInstance(Type.GetType(logicName));

                if (Type.GetType(logicName) != null)
                {
                    objInstance = Activator.CreateInstance(Type.GetType(logicName));
                }
                else
                {
                    objInstance = Activator.CreateInstance(Assembly.Load(strAssemblyName).GetType(logicName));
                }


                if (objInstance is LogicBase)
                {
                    LogicBase logic = (LogicBase)objInstance;

                    if (logic.SessionCheck)
                    {

                        //用户认证
                        hzyMessage = WSRR.CheckUser(hzyMessage.Session_ID, false);

                    }
                    logic.hzyMessage = this.hzyMessage;

                    if (objInstance is HZYLogicBase)
                    {
                        HZYLogicBase hzyLogic = (HZYLogicBase)objInstance;
                        hzyLogic.Request = request;

                    }
                    else
                    {
                        logic.Request = request;
                    }

                    if (logic is ILogicGetData)
                    {
                        ILogicGetData iLogic = (ILogicGetData)logic;
                        response = iLogic.GetData();

                        iLogic = null;
                    }
                    

                    logic = null;
                }
                else
                {

                }

                return response;
            }
            catch (Exception ex)
            {
                HZY.COM.Common.Log.WirteLog(ex, "4");
                throw ex;
            }
        }


    }

}