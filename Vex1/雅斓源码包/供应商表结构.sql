USE [GL_ERP]
GO

/****** Object:  Table [B01_MDM].[SU0_Supplier]    Script Date: 09/12/2013 10:36:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [B01_MDM].[SU0_Supplier](
	[SU0_CONO] [int] NULL,
	[SU0_DIVI] [int] NULL,
	[SU0_SupplierId] [nvarchar](50) NOT NULL,
	[SU0_SupplierCode] [nvarchar](50) NULL,
	[SU0_SupplierType] [nvarchar](50) NULL,
	[SU0_SupplierName] [nvarchar](128) NULL,
	[SU0_Address] [varchar](256) NULL,
	[SU0_Contact] [nvarchar](50) NULL,
	[SU0_Phone] [nvarchar](50) NULL,
	[SU0_Bank] [nvarchar](50) NULL,
	[SU0_BankAccount] [varchar](128) NULL,
	[SU0_BankAddress] [varchar](256) NULL,
	[SU0_BankSwift] [nvarchar](50) NULL,
	[SU0_Status] [nvarchar](50) NULL,
	[SU0_RgUser] [nvarchar](50) NULL,
	[SU0_RgDt] [datetime] NULL,
	[SU0_LmUser] [nvarchar](50) NULL,
	[SU0_LmDt] [datetime] NULL,
	[SU0_UptNo] [int] NULL,
 CONSTRAINT [PK_SUO_SUPPLIER] PRIMARY KEY CLUSTERED 
(
	[SU0_SupplierId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

