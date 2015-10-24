#pragma checksum "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\DBHelper\CJSearchSql.cs" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "24B2CCE6CABEDE0F03E7E6D2BC2F95E6A819A1DD"

#line 1 "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\DBHelper\CJSearchSql.cs"
using System;
using System.Collections.Generic;
using System.Text;
using Ext.Net;

/**
 * 作者：陈杰
 * QQ ： 710782046
 * Email：ovenjackchain@gmail.com
 * Web：http://www.chinacloudtech.com
 */
namespace DBHelper
{
    class CJSearchSql
    {
        public string GetConditonSQL(string conditions)
        {
            string _con = "";
            if (!string.IsNullOrEmpty(conditions))
            {
                FilterConditions fc = new FilterConditions(conditions);
                foreach (FilterCondition condition in fc.Conditions)
                {
                    Comparison comparison = condition.Comparison;
                    string field = condition.Name;
                    FilterType type = condition.FilterType;
                    switch (condition.FilterType)
                    {
                        case FilterType.Date:
                            if(comparison.ToString()=="Lt")
                                _con += "and " + field + " >= '" + condition.Value+"'";
                            else if(comparison.ToString()=="Gt")
                                _con += "and " + field + " <= '" + condition.Value + "'";
                            else
                                _con += "and CONVERT(varchar(100), "+field+", 111) = '" + condition.Value + "'";
                            break;
                        case FilterType.Numeric:
                            _con += "and "+field + " > " + condition.Value;
                            break;
                        case FilterType.String:
                            _con += "and " + field + " like '%" + condition.Value + "%' ";
                            break;
                    }
                }
                _con = _con.Substring(3);
            }
            return _con;
        }
    }
}


#line default
#line hidden
