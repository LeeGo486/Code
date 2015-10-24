USE [GL_ERP]
GO

/****** Object:  Table [M01_CONF].[DC0_Dictionary]    Script Date: 09/12/2013 10:38:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [M01_CONF].[DC0_Dictionary](
	[DC0_CONO] [int] NULL,
	[DC0_DIVI] [int] NULL,
	[DC0_DictId] [nvarchar](50) NOT NULL,
	[DC0_FartherDictId] [nvarchar](50) NULL,
	[DC0_DictName1] [nvarchar](50) NULL,
	[DC0_DictName2] [nvarchar](50) NULL,
	[DC0_DictName3] [nvarchar](50) NULL,
	[DC0_DictName4] [nvarchar](50) NULL,
	[DC0_DictName5] [nvarchar](50) NULL,
	[DC0_DictStatus] [nvarchar](50) NULL,
	[DC0_RgUser] [nvarchar](50) NULL,
	[DC0_RgDt] [datetime] NULL,
	[DC0_LmUser] [nvarchar](50) NULL,
	[DC0_LmDt] [datetime] NULL,
	[DC0_UptNo] [int] NULL,
 CONSTRAINT [PK_DC0_DICTIONARY] PRIMARY KEY NONCLUSTERED 
(
	[DC0_DictId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

