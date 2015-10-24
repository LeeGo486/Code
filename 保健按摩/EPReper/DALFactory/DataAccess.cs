using System;
using System.Reflection;
using System.Configuration;
namespace EPReper.DALFactory
{
	/// <summary>
    /// Abstract Factory pattern to create the DAL。
    /// 如果在这里创建对象报错，请检查web.config里是否修改了<add key="DAL" value="Maticsoft.SQLServerDAL" />。
	/// </summary>
	public sealed class DataAccess
	{
        private static readonly string AssemblyPath = "EPReper.SQLServerDAL";        
		public DataAccess()
		{ }

        #region CreateObject 

		//不使用缓存
        private static object CreateObjectNoCache(string AssemblyPath,string classNamespace)
		{		
			try
			{
				object objType = Assembly.Load(AssemblyPath).CreateInstance(classNamespace);	
				return objType;
			}
			catch//(System.Exception ex)
			{
				//string str=ex.Message;// 记录错误日志
				return null;
			}			
			
        }
		//使用缓存
		private static object CreateObject(string AssemblyPath,string classNamespace)
		{			
			object objType = DataCache.GetCache(classNamespace);
			if (objType == null)
			{
				try
				{
					objType = Assembly.Load(AssemblyPath).CreateInstance(classNamespace);					
					DataCache.SetCache(classNamespace, objType);// 写入缓存
				}
				catch//(System.Exception ex)
				{
					//string str=ex.Message;// 记录错误日志
				}
			}
			return objType;
		}
        #endregion

        #region CreateSysManage
       
             
        
   
		/// <summary>
		/// 创建Class数据层接口。
		/// </summary>
		public static EPReper.IDAL.IReperClass CreateReperClass()
		{

			string ClassNamespace = AssemblyPath +".ReperClass";
			object objType=CreateObject(AssemblyPath,ClassNamespace);
			return (EPReper.IDAL.IReperClass)objType;
		}

        public static EPReper.IDAL.IManager CreateManager()
        {
            string ClassNamespace = AssemblyPath + ".Manager";
            object objType = CreateObject(AssemblyPath, ClassNamespace);
            return (EPReper.IDAL.IManager)objType;
        }
		/// <summary>
		/// 创建RepairInfo数据层接口。
		/// </summary>
		public static EPReper.IDAL.IRepairInfo CreateRepairInfo()
		{

			string ClassNamespace = AssemblyPath +".RepairInfo";
			object objType=CreateObject(AssemblyPath,ClassNamespace);
			return (EPReper.IDAL.IRepairInfo)objType;
		}

		/// <summary>
		/// 创建Userinfo数据层接口。
		/// </summary>
        public static EPReper.IDAL.IUserinfo CreateUserinfo()
        {

            string ClassNamespace = AssemblyPath + ".Userinfo";
            object objType = CreateObject(AssemblyPath, ClassNamespace);
            return (EPReper.IDAL.IUserinfo)objType;
        }
        /// <summary>
        /// 创建SysInfo数据层接口
        /// </summary>
        /// <returns></returns>
		public static EPReper.IDAL.ISysInfo CreateSysInfo()
		{

            string ClassNamespace = AssemblyPath + ".SysInfo";
			object objType=CreateObject(AssemblyPath,ClassNamespace);
            return (EPReper.IDAL.ISysInfo)objType;
        }
        #endregion
    }
}