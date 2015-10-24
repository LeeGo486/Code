USE [GL_ERP]
GO

/****** Object:  Table [B01_MDM].[BD0_Brand]    Script Date: 09/12/2013 10:36:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [B01_MDM].[BD0_Brand](
	[BD0_CONO] [int] NULL,
	[BD0_DIVI] [int] NULL,
	[BD0_BrandId] [nvarchar](50) NOT NULL,
	[BD0_BrandCode] [nvarchar](50) NULL,
	[BD0_SU0_SupplierId] [nvarchar](50) NULL,
	[BD0_BrandName] [nvarchar](50) NULL,
	[BD0_CountryId] [nvarchar](50) NULL,
	[BD0_StyleId] [nvarchar](50) NULL,
	[BD0_CusGrpId] [nvarchar](50) NULL,
	[BD0_Status] [nvarchar](50) NULL,
	[BD0_RgUser] [nvarchar](50) NULL,
	[BD0_RgDt] [datetime] NULL,
	[BD0_LmUser] [nvarchar](50) NULL,
	[BD0_LmDt] [datetime] NULL,
	[BD0_UptNo] [int] NULL,
 CONSTRAINT [PK_BD0_Brand] PRIMARY KEY CLUSTERED 
(
	[BD0_BrandId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

