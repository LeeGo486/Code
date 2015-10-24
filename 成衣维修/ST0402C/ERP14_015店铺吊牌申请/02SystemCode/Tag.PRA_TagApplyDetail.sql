USE [StroeBusinissSystem]
GO

/****** Object:  Table [Tag].[PRAD_TagApplyDetail]    Script Date: 05/08/2014 14:52:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Tag].[PRAD_TagApplyDetail](
	[PRAD_Guid] [uniqueidentifier] NOT NULL,
	[PRA_Guid] [uniqueidentifier] NOT NULL,
	[PRAD_StyleID] [nvarchar](32) NULL,
	[PRAD_Total] [int] NULL,
	[PRAD_DIVI] [varchar](3) NULL,
	[PRAD_CONO] [nvarchar](12) NULL,
	[PRAD_LmDt] [datetime] NULL,
	[PRAD_LmUser] [varchar](50) NULL,
	[PRAD_RgDt] [datetime] NULL,
	[PRAD_RgUser] [varchar](50) NULL,
	[PRAD_UptNo] [int] NULL,
 CONSTRAINT [PK_PRAD_TAGAPPLYDETAIL] PRIMARY KEY CLUSTERED 
(
	[PRAD_Guid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

