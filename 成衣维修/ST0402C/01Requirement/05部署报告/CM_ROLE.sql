USE [epapp]
GO

/****** Object:  Table [dbo].[CM_ROLE]    Script Date: 12/15/2012 16:38:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[CM_ROLE](
	[roleid] [int] IDENTITY(1000000001,1) NOT NULL,
	[rolename] [varchar](128) NULL,
	[roledesc] [varchar](128) NULL,
 CONSTRAINT [PK_CM_ROLE] PRIMARY KEY CLUSTERED 
(
	[roleid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CM_ROLE', @level2type=N'COLUMN',@level2name=N'roleid'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CM_ROLE', @level2type=N'COLUMN',@level2name=N'rolename'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CM_ROLE', @level2type=N'COLUMN',@level2name=N'roledesc'
GO


