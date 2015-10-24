USE [GL_ERP]
GO

/****** Object:  Table [B02_Bill].[PR1_Order]    Script Date: 09/12/2013 10:37:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [B02_Bill].[PR1_Order](
	[PR1_CONO] [int] NULL,
	[PR1_DIVI] [int] NULL,
	[PR1_OrderId] [nvarchar](50) NULL,
	[PR1_OrderCode] [nvarchar](50) NULL,
	[PR1_OrderTypeId] [nvarchar](50) NULL,
	[PR1_PR0_ContractId] [nvarchar](50) NULL,
	[PR1_SU0_SupplierId] [nvarchar](50) NULL,
	[PR1_BD0_BrandId] [nvarchar](50) NULL,
	[PR1_PurchaseTotal] [int] NULL,
	[PR1_UnitID] [nvarchar](50) NULL,
	[PR1_POriginalAmount] [decimal](18, 6) NULL,
	[PR1_PurchaseAmount] [decimal](18, 6) NULL,
	[PR1_Discount] [decimal](18, 6) NULL,
	[PR1_CurrencyTypeId] [nvarchar](50) NULL,
	[PR1_ExchangeRate] [decimal](18, 6) NULL,
	[PR1_Tariff] [decimal](18, 6) NULL,
	[PR1_VAT] [decimal](18, 6) NULL,
	[PR1_Freight] [decimal](18, 2) NULL,
	[PR1_Times] [decimal](18, 6) NULL,
	[PR1_Status] [nvarchar](50) NULL,
	[PR1_RgUser] [nvarchar](50) NULL,
	[PR1_RgDt] [datetime] NULL,
	[PR1_LmUser] [nvarchar](50) NULL,
	[PR1_LmDt] [datetime] NULL,
	[PR1_UptNo] [int] NULL
) ON [PRIMARY]

GO

