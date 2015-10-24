USE [GL_ERP]
GO

/****** Object:  Table [B02_Bill].[PR1D_OrderDetail]    Script Date: 09/12/2013 10:37:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [B02_Bill].[PR1D_OrderDetail](
	[PR1D_CONO] [int] NULL,
	[PR1D_DIVI] [int] NULL,
	[PR1D_OrderDetailId] [nvarchar](50) NOT NULL,
	[PR1D_PR1_OrderId] [nvarchar](50) NULL,
	[PR1D_PD0_ProductId] [nvarchar](50) NULL,
	[PR1D_Total] [int] NULL,
	[PR1D_UnitID] [nvarchar](50) NULL,
	[PR1D_CurrencyTypeId] [nvarchar](50) NULL,
	[PR1D_POriginalPrice] [decimal](18, 6) NULL,
	[PR1D_PCurrencyPrice] [decimal](18, 6) NULL,
	[PR1D_SCurrencyPrice] [decimal](18, 6) NULL,
	[PR1D_Discount] [decimal](18, 6) NULL,
	[PR1D_EstimateCost] [decimal](18, 6) NULL,
	[PR1D_OriginalAmount] [decimal](18, 6) NULL,
	[PR1D_CurrencyAmount] [decimal](18, 6) NULL,
	[PR1D_Status] [nvarchar](50) NULL,
	[PR1D_SendDate] [date] NULL,
	[PR1D_Seq] [int] NULL,
	[PR1D_RgUser] [nvarchar](50) NULL,
	[PR1D_RgDt] [datetime] NULL,
	[PR1D_LmUser] [nvarchar](50) NULL,
	[PR1D_LmDt] [datetime] NULL,
	[PR1D_UptNo] [int] NULL
) ON [PRIMARY]

GO

