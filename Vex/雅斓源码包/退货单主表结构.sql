USE [GL_ERP]
GO

/****** Object:  Table [B02_Bill].[PRC_Return]    Script Date: 09/12/2013 10:38:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [B02_Bill].[PRC_Return](
	[PRC_CONO] [int] NULL,
	[PRC_DIVI] [int] NULL,
	[PRC_ReturnId] [nvarchar](50) NOT NULL,
	[PRC_ReturnCode] [nvarchar](50) NULL,
	[PRC_PR1_OrderId] [nvarchar](50) NULL,
	[PRC_PR1_OrderCode] [nvarchar](50) NULL,
	[PRC_SU0_SupplierId] [varchar](50) NULL,
	[PRC_Total] [int] NULL,
	[PRC_Amount] [numeric](18, 6) NULL,
	[PRC_Status] [nvarchar](50) NULL,
	[PRC_RgUser] [nvarchar](50) NULL,
	[PRC_RgDt] [datetime] NULL,
	[PRC_LmUser] [nvarchar](50) NULL,
	[PRC_LmDt] [datetime] NULL,
	[PRC_UptNo] [int] NULL,
 CONSTRAINT [PK_PRC_Return_1] PRIMARY KEY CLUSTERED 
(
	[PRC_ReturnId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

