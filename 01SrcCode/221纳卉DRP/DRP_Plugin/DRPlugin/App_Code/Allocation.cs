using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
///skcs 的摘要说明
/// </summary>
public class Allocation
{
    public Allocation()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    private string _skc;
    private int _count;
    public string sku
    {
        get { return _skc; }
        set { _skc = value; }
    }
    public int amount
    {
        get { return _count; }
        set { _count = value; }
    }
}