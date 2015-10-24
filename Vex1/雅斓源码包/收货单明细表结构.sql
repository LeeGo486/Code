USE [GL_ERP]
GO

/****** Object:  Table [B02_Bill].[PRBD_ReceiveDetail]    Script Date: 09/12/2013 10:38:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [B02_Bill].[PRBD_ReceiveDetail](
	[PRBD_CONO] [int] NULL,
	[PRBD_DIVI] [int] NULL,
	[PRBD_ReceiveDetailId] [nvarchar](50) NOT NULL,
	[PRBD_PRB_ReceiveId] [nvarchar](50) NULL,
	[PRBD_PRAD_ArrivalPlanDetailId] [nvarchar](50) NULL,
	[PRBD_PD0_ProductId] [nvarchar](50) NULL,
	[PRBD_UnitID] [nvarchar](50) NULL,
	[PRBD_POriginalPrice] [decimal](18, 6) NULL,
	[PRBD_PCurrencyPrice] [decimal](18, 6) NULL,
	[PRBD_SCurrencyPrice] [decimal](18, 6) NULL,
	[PRBD_DeptID] [nvarchar](50) NULL,
	[PRBD_StorageId] [nvarchar](50) NULL,
	[PRBD_PlanTotal] [int] NULL,
	[PRBD_PlanAmount] [decimal](18, 6) NULL,
	[PRBD_Total] [int] NULL,
	[PRBD_POSWHNumber] [nvarchar](50) NULL,
	[PRBD_Status] [nvarchar](50) NULL,
	[PRBD_RgUser] [nvarchar](50) NULL,
	[PRBD_RgDt] [datetime] NULL,
	[PRBD_LmUser] [nvarchar](50) NULL,
	[PRBD_LmDt] [datetime] NULL,
	[PRBD_UptNo] [int] NULL
) ON [PRIMARY]

GO

