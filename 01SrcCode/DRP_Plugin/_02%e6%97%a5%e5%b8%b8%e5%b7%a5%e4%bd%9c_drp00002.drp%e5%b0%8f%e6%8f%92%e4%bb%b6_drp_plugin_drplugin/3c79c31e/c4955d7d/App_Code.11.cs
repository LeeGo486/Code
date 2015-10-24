﻿#pragma checksum "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\Y_StylePrint.cs" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "AC645446D4D7569D6170E00BAEC08D2B8D197D01"

#line 1 "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\Y_StylePrint.cs"
using System;
using System.Collections;
using System.ComponentModel;

/**
 * 作者：陈杰
 * QQ  : 710782046
 * Email:ovenjackchain@gmail.com
 * Web :http://yj.ChinaCloudTech.com
 */
public class Y_StylePrint
{
    public Y_StylePrint() { }

    private int _id;
    private string _styleid;
    private string _gbcode;
    private string _safetype;
    private string _dotype;
    private string _grade;
    #region 属性
    /// <summary>
    /// 自增
    /// </summary>
    public int Id { get { return _id; } set { _id = value; } }

    /// <summary>
    /// 款式编码
    /// </summary>
    public string StyleId { get { return _styleid; } set { _styleid = value; } }

    /// <summary>
    /// 国标码
    /// </summary>
    public string GBCode { get { return _gbcode; } set { _gbcode = value; } }

    /// <summary>
    /// 安全类别
    /// </summary>
    public string SafeType { get { return _safetype; } set { _safetype = value; } }

    /// <summary>
    /// 执行标准
    /// </summary>
    public string DoType { get { return _dotype; } set { _dotype = value; } }

    /// <summary>
    /// 等级
    /// </summary>
    public string Grade { get { return _grade; } set { _grade = value; } }

    private string ReturnAutoID()
    {
        return "Id";
    }
    #endregion
}


#line default
#line hidden