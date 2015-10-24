USE [GL_ERP]
GO

/****** Object:  Table [B02_Bill].[PRAD_ArrivalPlanDetail]    Script Date: 09/12/2013 10:37:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [B02_Bill].[PRAD_ArrivalPlanDetail](
	[PRAD_CONO] [int] NULL,
	[PRAD_DIVI] [int] NULL,
	[PRAD_ArrivalPlanDetailId] [nvarchar](50) NOT NULL,
	[PRAD_PRA_ArrivalPlanId] [nvarchar](50) NULL,
	[PRAD_PD0_ProductId] [nvarchar](50) NULL,
	[PRAD_UnitID] [nvarchar](50) NULL,
	[PRAD_PR1D_OrderDetailId] [nvarchar](50) NULL,
	[PRAD_POriginalPrice] [nvarchar](50) NULL,
	[PRAD_PCurrencyPrice] [nvarchar](50) NULL,
	[PRAD_SCurrencyPrice] [nvarchar](50) NULL,
	[PRAD_ArrivalDate] [datetime] NULL,
	[PRAD_PerchaseTotal] [int] NULL,
	[PRAD_ArrivalTotal] [int] NULL,
	[PRAD_PlanTotal] [int] NULL,
	[PRAD_PlanArrival] [int] NULL,
	[PRAD_PlanArrivalAmount] [decimal](18, 6) NULL,
	[PRAD_TotalDiff] [int] NULL,
	[PRAD_Status] [nvarchar](50) NULL,
	[PRAD_RgUser] [nvarchar](50) NULL,
	[PRAD_RgDt] [datetime] NULL,
	[PRAD_LmUser] [nvarchar](50) NULL,
	[PRAD_LmDt] [datetime] NULL,
	[PRAD_UptNo] [int] NULL
) ON [PRIMARY]

GO

