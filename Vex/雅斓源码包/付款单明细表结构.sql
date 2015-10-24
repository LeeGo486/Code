USE [GL_ERP]
GO

/****** Object:  Table [B02_Bill].[FNPD_PayApplyDetail]    Script Date: 09/12/2013 10:36:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [B02_Bill].[FNPD_PayApplyDetail](
	[FNPD_CONO] [int] NULL,
	[FNPD_DIVI] [int] NULL,
	[FNPD_PayApplyDetailId] [nvarchar](50) NOT NULL,
	[FNPD_FNP_PayApplyId] [nvarchar](50) NULL,
	[FNPD_FNP_PayApplyCode] [nvarchar](50) NULL,
	[FNPD_RefBillDetailType] [nvarchar](50) NULL,
	[FNPD_RefBillDetailID] [nvarchar](50) NULL,
	[FNPD_Status] [nvarchar](50) NULL,
	[FNPD_RgUser] [nvarchar](50) NULL,
	[FNPD_RgDt] [datetime] NULL,
	[FNPD_LmUser] [nvarchar](50) NULL,
	[FNPD_LmDt] [datetime] NULL,
	[FNPD_UptNo] [int] NULL,
 CONSTRAINT [PK_FNPD_PAYAPPLYDETAIL] PRIMARY KEY CLUSTERED 
(
	[FNPD_PayApplyDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

