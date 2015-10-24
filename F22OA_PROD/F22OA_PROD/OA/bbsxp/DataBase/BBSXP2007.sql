if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_ForumPermissions_BBSXP_Forums]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_ForumPermissions] DROP CONSTRAINT FK_BBSXP_ForumPermissions_BBSXP_Forums
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_Threads_BBSXP_Forums]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_Threads] DROP CONSTRAINT FK_BBSXP_Threads_BBSXP_Forums
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_Forums_BBSXP_Groups]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_Forums] DROP CONSTRAINT FK_BBSXP_Forums_BBSXP_Groups
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_ForumPermissions_BBSXP_Roles]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_ForumPermissions] DROP CONSTRAINT FK_BBSXP_ForumPermissions_BBSXP_Roles
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_Users_BBSXP_Roles]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_Users] DROP CONSTRAINT FK_BBSXP_Users_BBSXP_Roles
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_PostRating_BBSXP_Threads]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_PostRating] DROP CONSTRAINT FK_BBSXP_PostRating_BBSXP_Threads
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_Posts_BBSXP_Threads]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_Posts] DROP CONSTRAINT FK_BBSXP_Posts_BBSXP_Threads
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_Votes_BBSXP_Threads]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_Votes] DROP CONSTRAINT FK_BBSXP_Votes_BBSXP_Threads
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_FavoriteForums_BBSXP_Users]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_FavoriteForums] DROP CONSTRAINT FK_BBSXP_FavoriteForums_BBSXP_Users
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_FavoriteThreads_BBSXP_Users]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_FavoriteThreads] DROP CONSTRAINT FK_BBSXP_FavoriteThreads_BBSXP_Users
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_FavoriteUsers_BBSXP_Users]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_FavoriteUsers] DROP CONSTRAINT FK_BBSXP_FavoriteUsers_BBSXP_Users
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_PostAttachments_BBSXP_Users]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_PostAttachments] DROP CONSTRAINT FK_BBSXP_PostAttachments_BBSXP_Users
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_PrivateMessages_BBSXP_Users]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_PrivateMessages] DROP CONSTRAINT FK_BBSXP_PrivateMessages_BBSXP_Users
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_Reputation_BBSXP_Users]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_Reputation] DROP CONSTRAINT FK_BBSXP_Reputation_BBSXP_Users
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_Subscriptions_BBSXP_Users]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_Subscriptions] DROP CONSTRAINT FK_BBSXP_Subscriptions_BBSXP_Users
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_BBSXP_Threads_BBSXP_Users]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[BBSXP_Threads] DROP CONSTRAINT FK_BBSXP_Threads_BBSXP_Users
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Advertisements]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Advertisements]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_EventLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_EventLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_FavoriteForums]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_FavoriteForums]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_FavoriteThreads]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_FavoriteThreads]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_FavoriteUsers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_FavoriteUsers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_ForumPermissions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_ForumPermissions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Forums]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Forums]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Groups]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Groups]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Links]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Links]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_PostAttachments]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_PostAttachments]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_PostRating]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_PostRating]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Posts]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Posts]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_PrivateMessages]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_PrivateMessages]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Reputation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Reputation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Subscriptions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Subscriptions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Ranks]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Ranks]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Roles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Roles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_SiteSettings]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_SiteSettings]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Statistics]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Statistics]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Threads]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Threads]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_UserActivation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_UserActivation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Users]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_UserOnline]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_UserOnline]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BBSXP_Votes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BBSXP_Votes]
GO

CREATE TABLE [dbo].[BBSXP_Advertisements] (
	[AdvertisementID] [int] IDENTITY (1, 1) NOT NULL ,
	[Body] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[ExpireDate] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_EventLog] (
	[UserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[ErrNumber] [int] NULL ,
	[EventDate] [datetime] NULL ,
	[MessageXML] [ntext] COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_FavoriteForums] (
	[FavoriteID] [int] IDENTITY (1, 1) NOT NULL ,
	[OwnerUserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[ForumID] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_FavoriteThreads] (
	[FavoriteID] [int] IDENTITY (1, 1) NOT NULL ,
	[OwnerUserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[ThreadID] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_FavoriteUsers] (
	[FavoriteID] [int] IDENTITY (1, 1) NOT NULL ,
	[OwnerUserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[FriendUserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_ForumPermissions] (
	[ForumID] [int] NOT NULL ,
	[RoleID] [int] NOT NULL ,
	[PermissionView] [int] NULL ,
	[PermissionRead] [int] NULL ,
	[PermissionPost] [int] NULL ,
	[PermissionReply] [int] NULL ,
	[PermissionEdit] [int] NULL ,
	[PermissionDelete] [int] NULL ,
	[PermissionCreatePoll] [int] NULL ,
	[PermissionVote] [int] NULL ,
	[PermissionAttachment] [int] NULL ,
	[PermissionManage] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Forums] (
	[ForumID] [int] IDENTITY (1, 1) NOT NULL ,
	[GroupID] [int] NOT NULL ,
	[ParentID] [int] NULL ,
	[SortOrder] [int] NULL ,
	[ForumName] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Moderated] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[TotalCategorys] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[ForumDescription] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[TodayPosts] [int] NULL ,
	[TotalThreads] [int] NULL ,
	[TotalPosts] [int] NULL ,
	[ForumUrl] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[IsActive] [int] NULL ,
	[MostRecentThreadID] [int] NULL ,
	[MostRecentPostSubject] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[MostRecentPostAuthor] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[MostRecentPostDate] [datetime] NULL ,
	[ForumRules] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[IsModerated] [int] NULL ,
	[DateCreated] [datetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Groups] (
	[GroupID] [int] IDENTITY (1, 1) NOT NULL ,
	[GroupName] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[SortOrder] [int] NULL ,
	[GroupDescription] [ntext] COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Links] (
	[LinkID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[URL] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Logo] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Intro] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[SortOrder] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_PostAttachments] (
	[UpFileID] [int] IDENTITY (1, 1) NOT NULL ,
	[UserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ThreadID] [int] NOT NULL ,
	[FileName] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ContentType] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[FilePath] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ContentSize] [int] NOT NULL ,
	[Description] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Created] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_PostRating] (
	[UserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ThreadID] [int] NOT NULL ,
	[Rating] [int] NOT NULL ,
	[DateCreated] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Posts] (
	[PostID] [int] IDENTITY (1, 1) NOT NULL ,
	[ThreadID] [int] NULL ,
	[ParentID] [int] NULL ,
	[PostAuthor] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[Subject] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Body] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[IPAddress] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[PostDate] [datetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_PrivateMessages] (
	[MessageID] [int] IDENTITY (1, 1) NOT NULL ,
	[SenderUserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[RecipientUserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Subject] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Body] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[IsRead] [int] NULL ,
	[IsRecipientDelete] [int] NULL ,
	[IsSenderDelete] [int] NULL ,
	[CreateTime] [datetime] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Reputation] (
	[ReputationID] [int] IDENTITY (1, 1) NOT NULL ,
	[Reputation] [int] NOT NULL ,
	[Comment] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[CommentFor] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[CommentBy] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[IPAddress] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[DateCreated] [datetime] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Ranks] (
	[RankID] [int] IDENTITY (1, 1) NOT NULL ,
	[RankName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[PostingCountMin] [int] NULL ,
	[RankIconUrl] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Roles] (
	[RoleID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[Description] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_SiteSettings] (
	[SiteSettingsXML] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[BBSxpVersion] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[CreateUserAgreement] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[GenericHeader] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[GenericTop] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[GenericBottom] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[BestOnline] [int] NOT NULL ,
	[BestOnlineTime] [datetime] NOT NULL ,
	[AdminNotes] [ntext] COLLATE Chinese_PRC_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Statistics] (
	[DaysUsers] [int] NULL ,
	[DaysPosts] [int] NULL ,
	[DaysTopics] [int] NULL ,
	[TotalUsers] [int] NULL ,
	[TotalPosts] [int] NULL ,
	[TotalTopics] [int] NULL ,
	[NewestUserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[DateCreated] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Subscriptions] (
	[SubscriptionID] [int] IDENTITY (1, 1) NOT NULL ,
	[UserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ThreadID] [int] NOT NULL ,
	[Email] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[SubscriptionDate] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Threads] (
	[ThreadID] [int] IDENTITY (1, 1) NOT NULL ,
	[ForumID] [int] NULL ,
	[ThreadEmoticonID] [int] NULL ,
	[ThreadStyle] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Topic] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Category] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Tags] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[PostAuthor] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[LastName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[PostTime] [datetime] NULL ,
	[LastTime] [datetime] NULL ,
	[LastViewedDate] [datetime] NOT NULL ,
	[IsGood] [int] NULL ,
	[ThreadTop] [int] NULL ,
	[IsLocked] [int] NULL ,
	[IsDel] [int] NULL ,
	[IsVote] [int] NULL ,
	[IsApproved] [int] NULL ,
	[TotalViews] [int] NULL ,
	[TotalReplies] [int] NULL ,
	[PostsTableName] [int] NULL ,
	[RatingSum] [int] NOT NULL ,
	[TotalRatings] [int] NOT NULL ,
	[ThreadStatus] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_UserActivation] (
	[ActivationKey] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[UserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[Email] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[DateCreated] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Users] (
	[UserID] [int] IDENTITY (1, 1) NOT NULL ,
	[UserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[UserPass] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserSex] [int] NULL ,
	[UserRoleID] [int] NOT NULL ,
	[UserAccountStatus] [int] NULL ,
	[UserEmail] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[WebAddress] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[WebLog] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[WebGallery] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Birthday] [datetime] NULL ,
	[NewMessage] [int] NULL ,
	[TotalPosts] [int] NULL ,
	[UserMoney] [int] NULL ,
	[Experience] [int] NULL ,
	[UserFaceUrl] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserRegisterIP] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserActivityIP] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserRegisterTime] [datetime] NOT NULL ,
	[UserPostTime] [datetime] NOT NULL ,
	[UserActivityTime] [datetime] NOT NULL ,
	[ReferrerName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[ModerationLevel] [int] NULL ,
	[RealName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[Occupation] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Address] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Interests] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserInfo] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[UserSign] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[UserBio] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[UserMate] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[BankMoney] [int] NOT NULL ,
	[BankDate] [datetime] NOT NULL ,
	[UserNote] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[UserTitle] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Reputation] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_UserOnline] (
	[ForumID] [int] NULL ,
	[SessionID] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserName] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[IPAddress] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[IsInvisible] [int] NULL ,
	[ForumName] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Act] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[ActURL] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[ComeTime] [datetime] NULL ,
	[LastTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BBSXP_Votes] (
	[ThreadID] [int] NULL ,
	[IsMultiplePoll] [int] NULL ,
	[Expiry] [datetime] NULL ,
	[Items] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[Result] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[BallotUserList] [ntext] COLLATE Chinese_PRC_CI_AS NULL ,
	[BallotIPList] [ntext] COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[BBSXP_Advertisements] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Advertisements_ExpireDate] DEFAULT (getdate()) FOR [ExpireDate]
GO

ALTER TABLE [dbo].[BBSXP_EventLog] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_EventLog_EventDate] DEFAULT (getdate()) FOR [EventDate]
GO

ALTER TABLE [dbo].[BBSXP_FavoriteForums] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_FavoriteForums_ForumID] DEFAULT (0) FOR [ForumID],
	CONSTRAINT [PK_BBSXP_FavoriteForums] PRIMARY KEY  CLUSTERED 
	(
		[FavoriteID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_FavoriteThreads] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_FavoriteThreads_ThreadID] DEFAULT (0) FOR [ThreadID],
	CONSTRAINT [PK_BBSXP_FavoriteThreads] PRIMARY KEY  CLUSTERED 
	(
		[FavoriteID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_FavoriteUsers] WITH NOCHECK ADD 
	CONSTRAINT [PK_BBSXP_FavoriteUsers] PRIMARY KEY  CLUSTERED 
	(
		[FavoriteID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_ForumPermissions] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_ForumPermissions_RoleID] DEFAULT (0) FOR [RoleID],
	CONSTRAINT [DF_BBSXP_ForumPermissions_PermissionView] DEFAULT (1) FOR [PermissionView],
	CONSTRAINT [DF_BBSXP_ForumPermissions_PermissionRead] DEFAULT (1) FOR [PermissionRead],
	CONSTRAINT [DF_BBSXP_ForumPermissions_PermissionPost] DEFAULT (1) FOR [PermissionPost],
	CONSTRAINT [DF_BBSXP_ForumPermissions_PermissionReply] DEFAULT (1) FOR [PermissionReply],
	CONSTRAINT [DF_BBSXP_ForumPermissions_PermissionEdit] DEFAULT (1) FOR [PermissionEdit],
	CONSTRAINT [DF_BBSXP_ForumPermissions_PermissionDelete] DEFAULT (0) FOR [PermissionDelete],
	CONSTRAINT [DF_BBSXP_ForumPermissions_PermissionCreatePoll] DEFAULT (1) FOR [PermissionCreatePoll],
	CONSTRAINT [DF_BBSXP_ForumPermissions_PermissionVote] DEFAULT (1) FOR [PermissionVote],
	CONSTRAINT [DF_BBSXP_ForumPermissions_PermissionAttachment] DEFAULT (1) FOR [PermissionAttachment],
	CONSTRAINT [DF_BBSXP_ForumPermissions_PermissionManage] DEFAULT (0) FOR [PermissionManage]
GO

ALTER TABLE [dbo].[BBSXP_Forums] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Forums_GroupID] DEFAULT (0) FOR [GroupID],
	CONSTRAINT [DF_BBSXP_Forums_ParentID] DEFAULT (0) FOR [ParentID],
	CONSTRAINT [DF_BBSXP_Forums_SortOrder] DEFAULT (1) FOR [SortOrder],
	CONSTRAINT [DF_BBSXP_Forums_TodayPosts] DEFAULT (0) FOR [TodayPosts],
	CONSTRAINT [DF_BBSXP_Forums_TotalThreads] DEFAULT (0) FOR [TotalThreads],
	CONSTRAINT [DF_BBSXP_Forums_TotalPosts] DEFAULT (0) FOR [TotalPosts],
	CONSTRAINT [DF_BBSXP_Forums_IsActive] DEFAULT (1) FOR [IsActive],
	CONSTRAINT [DF_BBSXP_Forums_MostRecentThreadID] DEFAULT (0) FOR [MostRecentThreadID],
	CONSTRAINT [DF_BBSXP_Forums_MostRecentPostDate] DEFAULT (getdate()) FOR [MostRecentPostDate],
	CONSTRAINT [DF_BBSXP_Forums_IsModerated] DEFAULT (0) FOR [IsModerated],
	CONSTRAINT [DF_BBSXP_Forums_DateCreated] DEFAULT (getdate()) FOR [DateCreated],
	CONSTRAINT [PK_BBSXP_Forums] PRIMARY KEY  CLUSTERED 
	(
		[ForumID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_Groups] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Groups_SortOrder] DEFAULT (1) FOR [SortOrder],
	CONSTRAINT [PK_BBSXP_Groups] PRIMARY KEY  CLUSTERED 
	(
		[GroupID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_Links] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Links_SortOrder] DEFAULT (1) FOR [SortOrder]
GO

ALTER TABLE [dbo].[BBSXP_PostAttachments] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_PostAttachments_ThreadID] DEFAULT (0) FOR [ThreadID],
	CONSTRAINT [DF_BBSXP_PostAttachments_ContentSize] DEFAULT (0) FOR [ContentSize],
	CONSTRAINT [DF_BBSXP_PostAttachments_Created] DEFAULT (getdate()) FOR [Created],
	CONSTRAINT [PK_BBSXP_PostAttachments] PRIMARY KEY  CLUSTERED 
	(
		[UpFileID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_PostRating] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_PostRating_ThreadID] DEFAULT (0) FOR [ThreadID],
	CONSTRAINT [DF_BBSXP_PostRating_Rating] DEFAULT (0) FOR [Rating],
	CONSTRAINT [DF_BBSXP_PostRating_DateCreated] DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[BBSXP_Posts] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Posts_ThreadID] DEFAULT (0) FOR [ThreadID],
	CONSTRAINT [DF_BBSXP_Posts_ParentID] DEFAULT (0) FOR [ParentID],
	CONSTRAINT [DF_BBSXP_Posts_PostDate] DEFAULT (getdate()) FOR [PostDate],
	CONSTRAINT [PK_BBSXP_Posts] PRIMARY KEY  CLUSTERED 
	(
		[PostID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_PrivateMessages] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_PrivateMessages_IsRead] DEFAULT (0) FOR [IsRead],
	CONSTRAINT [DF_BBSXP_PrivateMessages_IsRecipientDelete] DEFAULT (0) FOR [IsRecipientDelete],
	CONSTRAINT [DF_BBSXP_PrivateMessages_IsSenderDelete] DEFAULT (0) FOR [IsSenderDelete],
	CONSTRAINT [DF_BBSXP_PrivateMessages_CreateTime] DEFAULT (getdate()) FOR [CreateTime],
	CONSTRAINT [PK_BBSXP_PrivateMessages] PRIMARY KEY  CLUSTERED 
	(
		[MessageID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_Reputation] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Reputation_Reputation] DEFAULT (0) FOR [Reputation],
	CONSTRAINT [DF_BBSXP_Reputation_DateCreated] DEFAULT (getdate()) FOR [DateCreated],
	CONSTRAINT [PK_BBSXP_Reputation] PRIMARY KEY  CLUSTERED 
	(
		[ReputationID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_Ranks] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Ranks_PostingCountMin] DEFAULT (0) FOR [PostingCountMin]
GO

ALTER TABLE [dbo].[BBSXP_Roles] WITH NOCHECK ADD 
	CONSTRAINT [PK_BBSXP_Roles] PRIMARY KEY  CLUSTERED 
	(
		[RoleID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_SiteSettings] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_SiteSettings_BestOnline] DEFAULT (0) FOR [BestOnline],
	CONSTRAINT [DF_BBSXP_SiteSettings_BestOnlineTime] DEFAULT (getdate()) FOR [BestOnlineTime]
GO

ALTER TABLE [dbo].[BBSXP_Statistics] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Statistics_DaysUsers] DEFAULT (0) FOR [DaysUsers],
	CONSTRAINT [DF_BBSXP_Statistics_DaysPosts] DEFAULT (0) FOR [DaysPosts],
	CONSTRAINT [DF_BBSXP_Statistics_DaysTopics] DEFAULT (0) FOR [DaysTopics],
	CONSTRAINT [DF_BBSXP_Statistics_TotalUsers] DEFAULT (0) FOR [TotalUsers],
	CONSTRAINT [DF_BBSXP_Statistics_TotalPosts] DEFAULT (0) FOR [TotalPosts],
	CONSTRAINT [DF_BBSXP_Statistics_TotalTopics] DEFAULT (0) FOR [TotalTopics]
GO

ALTER TABLE [dbo].[BBSXP_Subscriptions] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Subscriptions_ThreadID] DEFAULT (0) FOR [ThreadID],
	CONSTRAINT [DF_BBSXP_Subscriptions_SubscriptionDate] DEFAULT (getdate()) FOR [SubscriptionDate],
	CONSTRAINT [PK_BBSXP_Subscriptions] PRIMARY KEY  CLUSTERED 
	(
		[SubscriptionID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_Threads] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Threads_ForumID] DEFAULT (0) FOR [ForumID],
	CONSTRAINT [DF_BBSXP_Threads_ThreadEmoticonID] DEFAULT (0) FOR [ThreadEmoticonID],
	CONSTRAINT [DF_BBSXP_Threads_PostTime] DEFAULT (getdate()) FOR [PostTime],
	CONSTRAINT [DF_BBSXP_Threads_LastTime] DEFAULT (getdate()) FOR [LastTime],
	CONSTRAINT [DF_BBSXP_Threads_LastViewedDate] DEFAULT (getdate()) FOR [LastViewedDate],
	CONSTRAINT [DF_BBSXP_Threads_IsGood] DEFAULT (0) FOR [IsGood],
	CONSTRAINT [DF_BBSXP_Threads_ThreadTop] DEFAULT (0) FOR [ThreadTop],
	CONSTRAINT [DF_BBSXP_Threads_IsLocked] DEFAULT (0) FOR [IsLocked],
	CONSTRAINT [DF_BBSXP_Threads_IsDel] DEFAULT (0) FOR [IsDel],
	CONSTRAINT [DF_BBSXP_Threads_IsVote] DEFAULT (0) FOR [IsVote],
	CONSTRAINT [DF_BBSXP_Threads_IsApproved] DEFAULT (1) FOR [IsApproved],
	CONSTRAINT [DF_BBSXP_Threads_TotalViews] DEFAULT (0) FOR [TotalViews],
	CONSTRAINT [DF_BBSXP_Threads_TotalReplies] DEFAULT (0) FOR [TotalReplies],
	CONSTRAINT [DF_BBSXP_Threads_RatingSum] DEFAULT (0) FOR [RatingSum],
	CONSTRAINT [DF_BBSXP_Threads_TotalRatings] DEFAULT (0) FOR [TotalRatings],
	CONSTRAINT [DF_BBSXP_Threads_ThreadStatus] DEFAULT (0) FOR [ThreadStatus],
	CONSTRAINT [PK_BBSXP_Threads] PRIMARY KEY  CLUSTERED 
	(
		[ThreadID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_UserActivation] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_UserActivation_DateCreated] DEFAULT (getdate()) FOR [DateCreated],
	CONSTRAINT [PK_BBSXP_UserActivation] PRIMARY KEY  CLUSTERED 
	(
		[ActivationKey]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_Users] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Users_UserSex] DEFAULT (0) FOR [UserSex],
	CONSTRAINT [DF_BBSXP_Users_UserRoleID] DEFAULT (3) FOR [UserRoleID],
	CONSTRAINT [DF_BBSXP_Users_UserAccountStatus] DEFAULT (1) FOR [UserAccountStatus],
	CONSTRAINT [DF_BBSXP_Users_NewMessage] DEFAULT (0) FOR [NewMessage],
	CONSTRAINT [DF_BBSXP_Users_TotalPosts] DEFAULT (0) FOR [TotalPosts],
	CONSTRAINT [DF_BBSXP_Users_UserMoney] DEFAULT (0) FOR [UserMoney],
	CONSTRAINT [DF_BBSXP_Users_Experience] DEFAULT (0) FOR [Experience],
	CONSTRAINT [DF_BBSXP_Users_UserRegisterTime] DEFAULT (getdate()) FOR [UserRegisterTime],
	CONSTRAINT [DF_BBSXP_Users_UserPostTime] DEFAULT (getdate()) FOR [UserPostTime],
	CONSTRAINT [DF_BBSXP_Users_UserActivityTime] DEFAULT (getdate()) FOR [UserActivityTime],
	CONSTRAINT [DF_BBSXP_Users_ModerationLevel] DEFAULT (0) FOR [ModerationLevel],
	CONSTRAINT [DF_BBSXP_Users_BankMoney] DEFAULT (0) FOR [BankMoney],
	CONSTRAINT [DF_BBSXP_Users_BankDate] DEFAULT (getdate()) FOR [BankDate],
	CONSTRAINT [DF_BBSXP_Users_Reputation] DEFAULT (0) FOR [Reputation],
	CONSTRAINT [PK_BBSXP_Users] PRIMARY KEY  CLUSTERED 
	(
		[UserName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BBSXP_UserOnline] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_UserOnline_ForumID] DEFAULT (0) FOR [ForumID],
	CONSTRAINT [DF_BBSXP_UserOnline_IsInvisible] DEFAULT (0) FOR [IsInvisible],
	CONSTRAINT [DF_BBSXP_UserOnline_ComeTime] DEFAULT (getdate()) FOR [ComeTime],
	CONSTRAINT [DF_BBSXP_UserOnline_LastTime] DEFAULT (getdate()) FOR [LastTime]
GO

ALTER TABLE [dbo].[BBSXP_Votes] WITH NOCHECK ADD 
	CONSTRAINT [DF_BBSXP_Votes_ThreadID] DEFAULT (0) FOR [ThreadID],
	CONSTRAINT [DF_BBSXP_Votes_IsMultiplePoll] DEFAULT (0) FOR [IsMultiplePoll]
GO

ALTER TABLE [dbo].[BBSXP_FavoriteForums] ADD 
	CONSTRAINT [FK_BBSXP_FavoriteForums_BBSXP_Users] FOREIGN KEY 
	(
		[OwnerUserName]
	) REFERENCES [dbo].[BBSXP_Users] (
		[UserName]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_FavoriteThreads] ADD 
	CONSTRAINT [FK_BBSXP_FavoriteThreads_BBSXP_Users] FOREIGN KEY 
	(
		[OwnerUserName]
	) REFERENCES [dbo].[BBSXP_Users] (
		[UserName]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_FavoriteUsers] ADD 
	CONSTRAINT [FK_BBSXP_FavoriteUsers_BBSXP_Users] FOREIGN KEY 
	(
		[OwnerUserName]
	) REFERENCES [dbo].[BBSXP_Users] (
		[UserName]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_ForumPermissions] ADD 
	CONSTRAINT [FK_BBSXP_ForumPermissions_BBSXP_Forums] FOREIGN KEY 
	(
		[ForumID]
	) REFERENCES [dbo].[BBSXP_Forums] (
		[ForumID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_BBSXP_ForumPermissions_BBSXP_Roles] FOREIGN KEY 
	(
		[RoleID]
	) REFERENCES [dbo].[BBSXP_Roles] (
		[RoleID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_Forums] ADD 
	CONSTRAINT [FK_BBSXP_Forums_BBSXP_Groups] FOREIGN KEY 
	(
		[GroupID]
	) REFERENCES [dbo].[BBSXP_Groups] (
		[GroupID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_PostAttachments] ADD 
	CONSTRAINT [FK_BBSXP_PostAttachments_BBSXP_Users] FOREIGN KEY 
	(
		[UserName]
	) REFERENCES [dbo].[BBSXP_Users] (
		[UserName]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_PostRating] ADD 
	CONSTRAINT [FK_BBSXP_PostRating_BBSXP_Threads] FOREIGN KEY 
	(
		[ThreadID]
	) REFERENCES [dbo].[BBSXP_Threads] (
		[ThreadID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_Posts] ADD 
	CONSTRAINT [FK_BBSXP_Posts_BBSXP_Threads] FOREIGN KEY 
	(
		[ThreadID]
	) REFERENCES [dbo].[BBSXP_Threads] (
		[ThreadID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_PrivateMessages] ADD 
	CONSTRAINT [FK_BBSXP_PrivateMessages_BBSXP_Users] FOREIGN KEY 
	(
		[SenderUserName]
	) REFERENCES [dbo].[BBSXP_Users] (
		[UserName]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_Reputation] ADD 
	CONSTRAINT [FK_BBSXP_Reputation_BBSXP_Users] FOREIGN KEY 
	(
		[CommentFor]
	) REFERENCES [dbo].[BBSXP_Users] (
		[UserName]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_Subscriptions] ADD 
	CONSTRAINT [FK_BBSXP_Subscriptions_BBSXP_Threads] FOREIGN KEY 
	(
		[ThreadID]
	) REFERENCES [dbo].[BBSXP_Threads] (
		[ThreadID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_Threads] ADD 
	CONSTRAINT [FK_BBSXP_Threads_BBSXP_Forums] FOREIGN KEY 
	(
		[ForumID]
	) REFERENCES [dbo].[BBSXP_Forums] (
		[ForumID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_BBSXP_Threads_BBSXP_Users] FOREIGN KEY 
	(
		[PostAuthor]
	) REFERENCES [dbo].[BBSXP_Users] (
		[UserName]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_Users] ADD 
	CONSTRAINT [FK_BBSXP_Users_BBSXP_Roles] FOREIGN KEY 
	(
		[UserRoleID]
	) REFERENCES [dbo].[BBSXP_Roles] (
		[RoleID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [dbo].[BBSXP_Votes] ADD 
	CONSTRAINT [FK_BBSXP_Votes_BBSXP_Threads] FOREIGN KEY 
	(
		[ThreadID]
	) REFERENCES [dbo].[BBSXP_Threads] (
		[ThreadID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

insert into [dbo].[BBSXP_SiteSettings](SiteSettingsXML,BBSxpVersion,GenericTop) values('<SiteName>BBSXP Forum Server</SiteName>
	<MetaDescription></MetaDescription>
	<MetaKeywords></MetaKeywords>
	<UserOnlineTime>20</UserOnlineTime>
	<Timeout>60</Timeout>
	<DefaultSiteStyle>default</DefaultSiteStyle>
	<CompanyName>Yuzi Corporation</CompanyName>
	<CompanyURL>http://www.yuzi.net</CompanyURL>
	<SiteDisabled>0</SiteDisabled>
	<SiteDisabledReason>论坛维护中，暂时无法访问！</SiteDisabledReason>
	<CacheName>BBSXP</CacheName>
	<CacheUpDateInterval>5</CacheUpDateInterval>
	<DefaultPasswordFormat>SHA1</DefaultPasswordFormat>
	<DisplayWhoIsOnline>1</DisplayWhoIsOnline>
	<DisplayStatistics>1</DisplayStatistics>
	<DisplayLink>1</DisplayLink>
	<DisplayBirthdays>1</DisplayBirthdays>
	<MinVoteOptions>2</MinVoteOptions>
	<MaxVoteOptions>20</MaxVoteOptions>
	<UpFileOption></UpFileOption>
	<UpFileTypes>gif|jpg|png|bmp|swf|txt|mid|doc|xls|zip|rar</UpFileTypes>
	<MaxPostAttachmentsSize>10240</MaxPostAttachmentsSize>
	<MaxFileSize>1024</MaxFileSize>
	<MaxFaceSize>30</MaxFaceSize>
	<WatermarkOption></WatermarkOption>
	<WatermarkType>0</WatermarkType>
	<WatermarkText>BBSXP</WatermarkText>
	<WatermarkImage>Images/Watermark.gif</WatermarkImage>
	<WatermarkPosition>4</WatermarkPosition>
	<SelectMailMode></SelectMailMode>
	<SmtpServerMail>yuzi@yuzi.net</SmtpServerMail>
	<SmtpServer></SmtpServer>
	<SmtpServerUserName></SmtpServerUserName>
	<SmtpServerPassword></SmtpServerPassword>
	<BannedHtmlLabel>link|script|object|iframe|form|style|div|caption|!--|meta</BannedHtmlLabel>
	<BannedHtmlEvent>javascript:|onerror|onload|onmouseover</BannedHtmlEvent>
	<BannedRegUserName>fuck|shit</BannedRegUserName>
	<BannedText>fuck|shit</BannedText>
	<BannedIP></BannedIP>
	<AccountActivation>0</AccountActivation>
	<AllowNewUserRegistration>1</AllowNewUserRegistration>
	<RequireAuthenticationForProfileViewing>0</RequireAuthenticationForProfileViewing>
	<NewUserModerationLevel>0</NewUserModerationLevel>
	<UserNameMinLength>3</UserNameMinLength>
	<UserNameMaxLength>15</UserNameMaxLength>
	<ReputationDefault>0</ReputationDefault>
	<ShowUserRates>5</ShowUserRates>
	<MinReputationPost>50</MinReputationPost>
	<MinReputationCount>0</MinReputationCount>
	<MaxReputationPerDay>10</MaxReputationPerDay>
	<ReputationRepeat>20</ReputationRepeat>
	<AdminReputationPower>10</AdminReputationPower>
	<InPrisonReputation>-9</InPrisonReputation>
	<CustomUserTitle>0</CustomUserTitle>
	<UserTitleMaxChars>25</UserTitleMaxChars>
	<UserTitleCensorWords>admin|forum|moderator</UserTitleCensorWords>
	<EnableBannedUsersToLogin>0</EnableBannedUsersToLogin>
	<EnableAntiSpamTextGenerateForRegister>0</EnableAntiSpamTextGenerateForRegister>
	<EnableAntiSpamTextGenerateForLogin>0</EnableAntiSpamTextGenerateForLogin>
	<EnableAntiSpamTextGenerateForPost>0</EnableAntiSpamTextGenerateForPost>
	<PostInterval>10</PostInterval>
	<RegUserTimePost>0</RegUserTimePost>
	<PostEditBodyAgeInMinutes>0</PostEditBodyAgeInMinutes>
	<PopularPostThresholdPosts>15</PopularPostThresholdPosts>
	<PopularPostThresholdViews>200</PopularPostThresholdViews>
	<DisplayEditNotes>1</DisplayEditNotes>
	<DisplayThreadStatus>1</DisplayThreadStatus>
	<DisplayPostTags>1</DisplayPostTags>
	<ThreadsPerPage>20</ThreadsPerPage>
	<PostsPerPage>15</PostsPerPage>
	<RSSDefaultThreadsPerFeed>20</RSSDefaultThreadsPerFeed>
	<EnableForumsRSS>1</EnableForumsRSS>
	<AllowDuplicatePosts>0</AllowDuplicatePosts>
	<PopularPostThresholdDays>3</PopularPostThresholdDays>
	<AllowLogin>1</AllowLogin>
	<EnableSignatures>1</EnableSignatures>
	<SignatureMaxLength>256</SignatureMaxLength>
	<AllowSignatures>1</AllowSignatures>
	<AllowGender>1</AllowGender>
	<AllowAvatars>1</AllowAvatars>
	<PublicMemberList>1</PublicMemberList>
	<MemberListAdvancedSearch>1</MemberListAdvancedSearch>
	<MemberListPageSize>20</MemberListPageSize>
	<EnableAvatars>1</EnableAvatars>
	<EnableRemoteAvatars>1</EnableRemoteAvatars>
	<AvatarHeight>150</AvatarHeight>
	<AvatarWidth>150</AvatarWidth>
	<IntegralAddThread>+2</IntegralAddThread>
	<IntegralAddPost>+1</IntegralAddPost>
	<IntegralAddValuedPost>+3</IntegralAddValuedPost>
	<IntegralDeleteThread>-2</IntegralDeleteThread>
	<IntegralDeletePost>-1</IntegralDeletePost>
	<IntegralDeleteValuedPost>-3</IntegralDeleteValuedPost>
	<IsShowSonForum>0</IsShowSonForum>
	<ViewMode>1</ViewMode>
	<AllowUserToSelectTheme>1</AllowUserToSelectTheme>
	<MaxPrivateMessageSize>100</MaxPrivateMessageSize>
	<WatermarkFontFamily>宋体</WatermarkFontFamily>
	<WatermarkFontSize>25</WatermarkFontSize>
	<WatermarkFontColor>#000000</WatermarkFontColor>
	<WatermarkFontIsBold>1</WatermarkFontIsBold>
	<WatermarkWidthPosition>left</WatermarkWidthPosition>
	<WatermarkHeightPosition>bottom</WatermarkHeightPosition>
	<CookiePath>/</CookiePath>
	<SiteUrl></SiteUrl>
	<NoCacheHeaders>0</NoCacheHeaders>','7.3.1','<a href="http://www.duoci.com" target="_blank"><img src="images/DuoCi_468x60.gif" border=0 /></a>')

insert into [dbo].[BBSXP_Links] (Name,URL,Logo,Intro) values ('BBSXP官方网','http://www.bbsxp.com/','images/BBSXP_88x31.gif','BBSXP官方技术支持站点')
insert into [dbo].[BBSXP_Links] (Name,URL,Logo,Intro) values ('多次搜索','http://www.duoci.com/','','多线程搜索引擎集合')


insert into [dbo].[BBSXP_Ranks] (RankName,PostingCountMin,RankIconUrl) values ('工兵','0','Images/level/0.gif')
insert into [dbo].[BBSXP_Ranks] (RankName,PostingCountMin,RankIconUrl) values ('排长','50','Images/level/1.gif')
insert into [dbo].[BBSXP_Ranks] (RankName,PostingCountMin,RankIconUrl) values ('连长','150','Images/level/2.gif')
insert into [dbo].[BBSXP_Ranks] (RankName,PostingCountMin,RankIconUrl) values ('营长','500','Images/level/3.gif')
insert into [dbo].[BBSXP_Ranks] (RankName,PostingCountMin,RankIconUrl) values ('团长','1000','Images/level/4.gif')
insert into [dbo].[BBSXP_Ranks] (RankName,PostingCountMin,RankIconUrl) values ('旅长','2000','Images/level/5.gif')
insert into [dbo].[BBSXP_Ranks] (RankName,PostingCountMin,RankIconUrl) values ('师长','5000','Images/level/6.gif')
insert into [dbo].[BBSXP_Ranks] (RankName,PostingCountMin,RankIconUrl) values ('军长','20000','Images/level/7.gif')
insert into [dbo].[BBSXP_Ranks] (RankName,PostingCountMin,RankIconUrl) values ('司令','50000','Images/level/8.gif')

SET IDENTITY_INSERT BBSXP_Roles ON
insert into [dbo].[BBSXP_Roles] (RoleID,Name,Description) values ('0','Everyone','不需要添加用户到该角色，该角色仅仅是作为权限隐射，所有的匿名用户和注册用户都属于该角色。')
insert into [dbo].[BBSXP_Roles] (RoleID,Name,Description) values ('1','管理员','享有论坛的最高权限，可以管理整个论坛。')
insert into [dbo].[BBSXP_Roles] (RoleID,Name,Description) values ('2','超级版主','可以管理论坛上的所有版块。')
insert into [dbo].[BBSXP_Roles] (RoleID,Name,Description) values ('3','注册会员','所有注册用户自动属于该角色。')
SET IDENTITY_INSERT BBSXP_Roles OFF
print 'BBSXP 2007(Build 7.3.1) 数据库创建成功！'
