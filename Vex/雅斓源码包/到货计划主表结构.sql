USE [GL_ERP]
GO

/****** Object:  Table [B02_Bill].[PRA_ArrivalPlan]    Script Date: 09/12/2013 10:37:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [B02_Bill].[PRA_ArrivalPlan](
	[PRA_CONO] [int] NULL,
	[PRA_DIVI] [int] NULL,
	[PRA_ArrivalPlanId] [nvarchar](50) NOT NULL,
	[PRA_ArrivalPlanCode] [nvarchar](50) NULL,
	[PRA_PR1_OrderId] [nvarchar](50) NULL,
	[PRA_SU0_SupplierId] [nvarchar](50) NULL,
	[PRA_UnitID] [nvarchar](50) NULL,
	[PRA_PerchaseTotal] [int] NULL,
	[PRA_ArrivalTotal] [int] NULL,
	[PRA_PlanTotal] [int] NULL,
	[PRA_PerchaseAmount] [decimal](18, 6) NULL,
	[PRA_ArrivalAmount] [decimal](18, 6) NULL,
	[PRA_PlanAmount] [decimal](18, 6) NULL,
	[PRA_TotalDiff] [int] NULL,
	[PRA_AmountDiff] [numeric](18, 6) NULL,
	[PRA_Status] [nvarchar](50) NULL,
	[PRA_RgUser] [nvarchar](50) NULL,
	[PRA_RgDt] [datetime] NULL,
	[PRA_LmUser] [nvarchar](50) NULL,
	[PRA_LmDt] [datetime] NULL,
	[PRA_UptNo] [int] NULL,
 CONSTRAINT [PK_PRA_ARRIVALPLAN] PRIMARY KEY CLUSTERED 
(
	[PRA_ArrivalPlanId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

