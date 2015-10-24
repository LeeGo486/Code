#pragma checksum "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\ExcelHelper.cs" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "A279742616F69044F17BD53E52D1EF1A716965E1"

#line 1 "E:\02日常工作\DRP00002.DRP小插件\DRP_Plugin\DRPlugin\App_Code\ExcelHelper.cs"
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Web;

/// <summary>
/// ExcelHelper 的摘要说明
/// </summary>
public class ExcelHelper
{
	public ExcelHelper()
	{
		
	}

    public static bool ExportExcelWithAspose(System.Data.DataTable dt, string path)
    {
        bool succeed = false;
        if (dt != null)
        {
            try
            {
                Aspose.Cells.License li = new Aspose.Cells.License();
                string lic = @"<License>
                                  <Data>
                                    <SerialNumber>aed83727-21cc-4a91-bea4-2607bf991c21</SerialNumber>
                                    <EditionType>Enterprise</EditionType>
                                    <Products>
                                      <Product>Aspose.Total</Product>
                                    </Products>
                                  </Data>
                                 <Signature>CxoBmxzcdRLLiQi1kzt5oSbz9GhuyHHOBgjTf5w/wJ1V+lzjBYi8o7PvqRwkdQo4tT4dk3PIJPbH9w5Lszei1SV/smkK8SCjR8kIWgLbOUFBvhD1Fn9KgDAQ8B11psxIWvepKidw8ZmDmbk9kdJbVBOkuAESXDdtDEDZMB/zL7Y=</Signature>
                                </License>";
                Stream s = new MemoryStream(ASCIIEncoding.Default.GetBytes(lic));
                li.SetLicense(s);

                Aspose.Cells.Workbook workbook = new Aspose.Cells.Workbook();
                Aspose.Cells.Worksheet cellSheet = workbook.Worksheets[0];

                cellSheet.Name = "Sheet1";

                int rowIndex = 0;
                int colIndex = 0;
                int colCount = dt.Columns.Count;
                int rowCount = dt.Rows.Count;

                //列名的处理
                for (int i = 0; i < colCount; i++)
                {
                    cellSheet.Cells[rowIndex, colIndex].PutValue(dt.Columns[i].ColumnName);
                    cellSheet.Cells[rowIndex, colIndex].Style.Font.IsBold = true;
                    cellSheet.Cells[rowIndex, colIndex].Style.Font.Name = "宋体";
                    colIndex++;
                }

                Aspose.Cells.Style style = workbook.Styles[workbook.Styles.Add()];
                style.Font.Name = "Arial";
                style.Font.Size = 10;
                Aspose.Cells.StyleFlag styleFlag = new Aspose.Cells.StyleFlag();
                cellSheet.Cells.ApplyStyle(style, styleFlag);

                rowIndex++;

                for (int i = 0; i < rowCount; i++)
                {
                    colIndex = 0;
                    for (int j = 0; j < colCount; j++)
                    {
                        cellSheet.Cells[rowIndex, colIndex].PutValue(dt.Rows[i][j].ToString());
                        colIndex++;
                    }
                    rowIndex++;
                }
                cellSheet.AutoFitColumns();

                path = Path.GetFullPath(path);
                workbook.Save(path);
                succeed = true;
            }
            catch (Exception ex)
            {
                succeed = false;
            }
        }

        return succeed;
    }
}

#line default
#line hidden
