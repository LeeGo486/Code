using System;
using System.Collections.Generic;
using System.Web;

/**
 * 作者：陈杰
 * QQ  : 710782046
 * Email:ovenjackchain@gmail.com
 * Web :http://yj.ChinaCloudTech.com
 */

public class Y_StyleFoundation
{
    public Y_StyleFoundation() { }
    private int _Id;
    private string _BrName;
    private string _BrId;
    private string _Production;
    private string _ClothingId;
    private string _StyleId;
    private string _ColorId;
    private string _SizeId;
    private decimal _J_Price;
    private decimal _J_Cost;
    private string _S_Name;
    private string _Fabric;
    private int _PrintState;
    private int _St_Year;
    private string _St_Month;
    private string _St_Xl;
    private string _St_Dl;
    private string _St_Xz;
    private string _OldClothingId;
    private string _OldStyleId;
    private string _OldColorId;
    private string _OldSizeId;
    private string _Remark;
    #region 属性
    public int Id { get { return _Id; } set { _Id = value; } }
    public string BrName { get { return _BrName; } set { _BrName = value; } }
    public string BrId { get { return _BrId; } set { _BrId = value; } }
    public string Production { get { return _Production; } set { _Production = value; } }
    public string ClothingId { get { return _ClothingId; } set { _ClothingId = value; } }
    public string StyleId { get { return _StyleId; } set { _StyleId = value; } }
    public string ColorId { get { return _ColorId; } set { _ColorId = value; } }
    public string SizeId { get { return _SizeId; } set { _SizeId = value; } }
    public decimal J_Price { get { return _J_Price; } set { _J_Price = value; } }
    public decimal J_Cost { get { return _J_Cost; } set { _J_Cost = value; } }
    public string S_Name { get { return _S_Name; } set { _S_Name = value; } }
    public string Fabric { get { return _Fabric; } set { _Fabric = value; } }
    public int PrintState { get { return _PrintState; } set { _PrintState = value; } }
    public int St_Year { get { return _St_Year; } set { _St_Year = value; } }
    public string St_Month { get { return _St_Month; } set { _St_Month = value; } }
    public string St_Xl { get { return _St_Xl; } set { _St_Xl = value; } }
    public string St_Dl { get { return _St_Dl; } set { _St_Dl = value; } }
    public string St_Xz { get { return _St_Xz; } set { _St_Xz = value; } }
    public string OldClothingId { get { return _OldClothingId; } set { _OldClothingId = value; } }
    public string OldStyleId { get { return _OldStyleId; } set { _OldStyleId = value; } }
    public string OldColorId { get { return _OldColorId; } set { _OldColorId = value; } }
    public string OldSizeId { get { return _OldSizeId; } set { _OldSizeId = value; } }
    public string Remark { get { return _Remark; } set { _Remark = value; } }

    private string ReturnAutoID()
    {
        return "Id";
    }
    #endregion
}