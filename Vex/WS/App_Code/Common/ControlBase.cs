namespace HZY.COM.Common
{
    using HZY.COM.Common.Base;
    using System;
    using System.Data;
    using System.Reflection;
    
    public class ControlBase
    {
        public HZYmessage hzyMessage = new HZYmessage();
        public DataSet RequestBak;
        
        public bool Excute(string logicName, DataSet request)
        {
            bool flag2;
            bool flag = false;
            try
            {
                string assemblyString = logicName.Substring(0, logicName.LastIndexOf("."));
                object obj2 = null;
                if (Type.GetType(logicName) != null)
                {
                    obj2 = Activator.CreateInstance(Type.GetType(logicName));
                }
                else
                {
                    obj2 = Activator.CreateInstance(Assembly.Load(assemblyString).GetType(logicName));
                }
                if (obj2 is LogicBase)
                {
                    LogicBase base2 = (LogicBase) obj2;
                    if (base2 is ILogicExecute)
                    {
                        base2.Request = request;
                        if (base2.SessionCheck)
                        {
                            this.hzyMessage = HZY.COM.Common.Common.CheckUser(this.hzyMessage.Session_ID);
                        }
                        base2.hzyMessage = this.hzyMessage;
                        base2.RequestBak = this.RequestBak;
                        ILogicExecute execute = (ILogicExecute) base2;
                        flag = execute.Execute();
                        execute = null;
                    }
                    base2 = null;
                }
                flag2 = flag;
            }
            catch (Exception exception)
            {
                Log.WirteLog(exception, "3");
                throw exception;
            }
            return flag2;
        }
        
        public DataSet GetData(string logicName, DataSet request)
        {
            DataSet set = null;
            DataSet set2;
            try
            {
                string assemblyString = logicName.Substring(0, logicName.LastIndexOf("."));
                object obj2 = null;
                if (Type.GetType(logicName) != null)
                {
                    obj2 = Activator.CreateInstance(Type.GetType(logicName));
                }
                else
                {
                    obj2 = Activator.CreateInstance(Assembly.Load(assemblyString).GetType(logicName));
                }
                if (obj2 is LogicBase)
                {
                    LogicBase base2 = (LogicBase) obj2;
                    if (base2.SessionCheck)
                    {
                        this.hzyMessage = HZY.COM.Common.Common.CheckUser(this.hzyMessage.Session_ID);
                    }
                    base2.hzyMessage = this.hzyMessage;
                    base2.RequestBak = this.RequestBak;
                    if (obj2 is HZYLogicBase)
                    {
                        HZYLogicBase base3 = (HZYLogicBase) obj2;
                        base3.Request = request;
                    }
                    else
                    {
                        base2.Request = request;
                    }
                    if (base2 is ILogicGetData)
                    {
                        ILogicGetData data = (ILogicGetData) base2;
                        set = data.GetData();
                        data = null;
                    }
                    base2 = null;
                }
                set2 = set;
            }
            catch (Exception exception)
            {
                Log.WirteLog(exception, "4");
                throw exception;
            }
            return set2;
        }
    }
}