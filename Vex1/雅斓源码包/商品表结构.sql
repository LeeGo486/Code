USE [GL_ERP]
GO

/****** Object:  Table [B01_MDM].[PD0_Product]    Script Date: 09/12/2013 10:36:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [B01_MDM].[PD0_Product](
	[PD0_CONO] [int] NULL,
	[PD0_DIVI] [int] NULL,
	[PD0_ProductId] [nvarchar](50) NOT NULL,
	[PD0_SUO_SupplierId] [nvarchar](50) NULL,
	[PD0_BD0_BrandId] [nvarchar](50) NULL,
	[PD0_ProductCodeSU] [nvarchar](128) NULL,
	[PD0_ColorSUId] [nvarchar](50) NULL,
	[PD0_ColorBSUId] [nvarchar](50) NULL,
	[PD0_SizeSUId] [nvarchar](50) NULL,
	[PD0_SKUSU] [nvarchar](256) NULL,
	[PD0_Code] [nvarchar](50) NULL,
	[PD0_ColorId] [nvarchar](50) NULL,
	[PD0_SizeId] [nvarchar](50) NULL,
	[PD0_SKU] [nvarchar](128) NULL,
	[PD0_YearId] [nvarchar](50) NULL,
	[PD0_SeasonId] [nvarchar](50) NULL,
	[PD0_Lvl0] [nvarchar](50) NULL,
	[PD0_Lvl1] [nvarchar](50) NULL,
	[PD0_Lvl2] [nvarchar](50) NULL,
	[PD0_Lvl3] [nvarchar](50) NULL,
	[PD0_SourceCountry] [nvarchar](128) NULL,
	[PD0_Composition] [nvarchar](1024) NULL,
	[PD0_QulityLevel] [nvarchar](50) NULL,
	[PD0_StandardId] [nvarchar](50) NULL,
	[PD0_SecurityLevelId] [nvarchar](50) NULL,
	[PD0_PurchasePrice] [decimal](18, 6) NULL,
	[PD0_SalePrice] [decimal](18, 6) NULL,
	[PD0_UnitId] [nvarchar](50) NULL,
	[PD0_IsPrinted] [nvarchar](50) NULL,
	[PD0_PicPath] [nvarchar](250) NULL,
	[PD0_Status] [nvarchar](50) NULL,
	[PD0_RgUser] [nvarchar](50) NULL,
	[PD0_RgDt] [datetime] NULL,
	[PD0_LmUser] [nvarchar](50) NULL,
	[PD0_LmDt] [datetime] NULL,
	[PD0_UptNo] [int] NULL,
 CONSTRAINT [PK_PD0_PRODUCT] PRIMARY KEY CLUSTERED 
(
	[PD0_ProductId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [B01_MDM].[PD0_Product] ADD  CONSTRAINT [DF_PD0_Product_PD0_PurchasePrice]  DEFAULT ((0)) FOR [PD0_PurchasePrice]
GO

ALTER TABLE [B01_MDM].[PD0_Product] ADD  CONSTRAINT [DF_PD0_Product_PD0_SalePrice]  DEFAULT ((0)) FOR [PD0_SalePrice]
GO

