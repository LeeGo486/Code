USE [GL_ERP]
GO

/****** Object:  Table [B02_Bill].[PRCD_ReturnDetail]    Script Date: 09/12/2013 10:38:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [B02_Bill].[PRCD_ReturnDetail](
	[PRCD_CONO] [int] NULL,
	[PRCD_DIVI] [int] NULL,
	[PRCD_ReturnDetailId] [nvarchar](50) NOT NULL,
	[PRCD_PRC_ReturnId] [nvarchar](50) NULL,
	[PRCD_PD0_ProductId] [nvarchar](50) NULL,
	[PRCD_POriginalPrice] [decimal](18, 6) NULL,
	[PRCD_PCurrencyPrice] [decimal](18, 6) NULL,
	[PRCD_SCurrencyPrice] [decimal](18, 6) NULL,
	[PRCD_RetDeptID] [nvarchar](50) NULL,
	[PRCD_POSRetCode] [nvarchar](50) NULL,
	[PRCD_Total] [int] NULL,
	[PRCD_UnitID] [nvarchar](50) NULL,
	[PRCD_Amount] [numeric](18, 6) NULL,
	[PRCD_Reson] [nvarchar](max) NULL,
	[PRCD_RgUser] [nvarchar](50) NULL,
	[PRCD_RgDt] [datetime] NULL,
	[PRCD_LmUser] [nvarchar](50) NULL,
	[PRCD_LmDt] [datetime] NULL,
	[PRCD_UptNo] [int] NULL,
	[PRCD_Status] [nvarchar](50) NULL,
	[PRCD_PR1D_OrderDetailId] [nvarchar](50) NULL,
 CONSTRAINT [PK_PRCD_ReturnDetail_1] PRIMARY KEY CLUSTERED 
(
	[PRCD_ReturnDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

