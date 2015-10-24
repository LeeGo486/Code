USE [GL_ERP]
GO

/****** Object:  Table [B02_Bill].[PRB_Receipt]    Script Date: 09/12/2013 10:37:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [B02_Bill].[PRB_Receipt](
	[PRB_CONO] [int] NULL,
	[PRB_DIVI] [int] NULL,
	[PRB_ReceiptId] [nvarchar](50) NOT NULL,
	[PRB_ReceiptCode] [nvarchar](50) NOT NULL,
	[PRB_PRA_ArrivalPlanId] [nvarchar](50) NULL,
	[PRB_TypeId] [nvarchar](50) NULL,
	[PRB_SU0_SupplierId] [nvarchar](50) NULL,
	[PRB_PlanTotal] [int] NULL,
	[PRB_PlanAmount] [decimal](18, 6) NULL,
	[PRB_ReceiptTotal] [int] NULL,
	[PRB_ReceiptAmount] [decimal](18, 6) NULL,
	[PRB_ReceiptDate] [datetime] NULL,
	[PRB_Status] [nvarchar](50) NULL,
	[PRB_RgUser] [nvarchar](50) NULL,
	[PRB_RgDt] [datetime] NULL,
	[PRB_LmUser] [nvarchar](50) NULL,
	[PRB_LmDt] [datetime] NULL,
	[PRB_UptNo] [int] NULL,
 CONSTRAINT [PK_PRB_RECEIPT] PRIMARY KEY CLUSTERED 
(
	[PRB_ReceiptId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

