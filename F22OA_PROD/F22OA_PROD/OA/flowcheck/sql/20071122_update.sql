if not exists (select 1
            from  sysobjects
           where  id = object_id('O_Base')
            and   type = 'U')
begin
/*==============================================================*/
/* Table: O_Base                                                */
/*==============================================================*/
create table O_Base (
   baseid               int                  identity,
   typeid               int                  null,
   basename             varchar(200)         null,
   comment              varchar(100)         null,
   crdate               datetime             null default getdate(),
   constraint PK_O_BASE primary key  (baseid)
)
end
go

if not exists (select 1
            from  sysobjects
           where  id = object_id('O_Basesub')
            and   type = 'U')
begin
/*==============================================================*/
/* Table: O_Basesub                                             */
/*==============================================================*/
create table O_Basesub (
   Sid                  int                  identity,
   baseid               int                  null,
   orders               int                  null,
   userid               varchar(16)          null,
   cltime               numeric(8,2)         null,
   ifedit               int                  null,
   comment              varchar(100)         null,
   crdate               datetime             null,
   constraint PK_O_BASESUB primary key  (Sid)
)

alter table O_Basesub
   add constraint FK_O_BASESUB_O_BASE foreign key (baseid)
      references O_Base (baseid)
      on update cascade on delete cascade
end
go

if not exists (select 1
            from  sysobjects
           where  id = object_id('O_State')
            and   type = 'U')
begin
/*==============================================================*/
/* Table: O_State                                               */
/*==============================================================*/
create table O_State (
   StateID              int                  identity,
   orders               int                  null,
   Statename            varchar(20)          null,
   color                varchar(10)          null,
   comment              varchar(50)          null,
   crdate               datetime             null,
   constraint PK_O_STATE primary key  (StateID)
)
end
go


if not exists (select 1
            from  sysobjects
           where  id = object_id('O_type')
            and   type = 'U')
begin
/*==============================================================*/
/* Table: O_type                                                */
/*==============================================================*/
create table O_type (
   typeid               int                  identity,
   typename             varchar(20)          null,
   comment              varchar(50)          null,
   crdate               datetime             null default getdate(),
   constraint PK_O_TYPE primary key  (typeid)
)
end
go


if not exists (select 1
            from  sysobjects
           where  id = object_id('O_Threads')
            and   type = 'U')
begin
/*==============================================================*/
/* Table: O_Threads                                             */
/*==============================================================*/
create table O_Threads (
   TID                  int                  identity,
   typeid               int                  null,
   baseid               int                  null,
   stateid              int                  null,
   title                varchar(150)         null,
   content              text                 null,
   crdate               datetime             null default getdate(),
   crname               varchar(16)          null,
   clname               varchar(16)          null,
   lastname             varchar(16)          null,
   lastdatetime         datetime             null,
   isov                 int                  null,
   constraint PK_O_THREADS primary key  (TID)
)
end
go


if not exists (select 1
            from  sysobjects
           where  id = object_id('O_Threadsub')
            and   type = 'U')
begin
/*==============================================================*/
/* Table: O_Threadsub                                           */
/*==============================================================*/
create table O_Threadsub (
   SID                  int                  identity,
   tid                  int                  null,
   content              text                 null,
   rpname               varchar(16)          null,
   rpdatetime           datetime             null default getdate(),
   constraint PK_O_THREADSUB primary key  (SID)
)

alter table O_Threadsub
   add constraint FK_O_THREADSUB_O_THREADS foreign key (tid)
      references O_Threads (TID)
      on update cascade on delete cascade
end
go


if not exists (select 1
            from  sysobjects
           where  id = object_id('O_Log')
            and   type = 'U')
begin
/*==============================================================*/
/* Table: O_Log                                                 */
/*==============================================================*/
create table O_Log (
   Logid                int                  identity,
   Tid                  int                  null,
   Logcomment           varchar(100)         null,
   crname               varchar(16)          null,
   crdate               datetime             null default getdate(),
   constraint PK_O_LOG primary key  (Logid)
)
end
go


if not exists (select 1
            from  sysobjects
           where  id = object_id('O_Logov')
            and   type = 'U')
begin
/*==============================================================*/
/* Table: O_Logov                                               */
/*==============================================================*/
create table O_Logov (
   Lid                  int                  identity,
   tid                  int                  null,
   userid               varchar(16)           null,
   comment              varchar(50)          null,
   crdate               datetime             null default getdate(),
   constraint PK_O_LOGOV primary key  (Lid)
)
end
go


if not exists (select 1
            from  sysobjects
           where  id = object_id('O_Logsee')
            and   type = 'U')
begin
/*==============================================================*/
/* Table: O_Logsee                                              */
/*==============================================================*/
create table O_Logsee (
   Lid                  int                  identity,
   tid                  int                  null,
   userid               varchar(16)           null,
   comment              varchar(50)          null,
   crdate               datetime             null default getdate(),
   constraint PK_O_LOGSEE primary key  (Lid)
)
end
go



