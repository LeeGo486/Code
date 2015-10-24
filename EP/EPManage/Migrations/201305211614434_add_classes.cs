namespace EPManageWeb.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class add_classes : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.SessionUsers",
                c => new
                    {
                        Id = c.Guid(nullable: false),
                        SessionId = c.String(maxLength: 50),
                        UserId = c.Int(nullable: false),
                        LastActivityDT = c.DateTime(nullable: false),
                        LoginDT = c.DateTime(nullable: false),
                        RemoteIP = c.String(maxLength: 50),
                        Status = c.String(maxLength: 50),
                        CreateDT = c.DateTime(nullable: false),
                        ModifiedDT = c.DateTime(nullable: false),
                        IsDeleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Users", t => t.UserId, cascadeDelete: true)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.Users",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        UserName = c.String(),
                        Password = c.String(),
                        RealName = c.String(),
                        CreateDT = c.DateTime(nullable: false),
                        ModifiedDT = c.DateTime(nullable: false),
                        IsDeleted = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.ClothesTypes",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(maxLength: 20),
                        CreateDT = c.DateTime(nullable: false),
                        ModifiedDT = c.DateTime(nullable: false),
                        IsDeleted = c.Boolean(nullable: false),
                        Parent_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.ClothesTypes", t => t.Parent_Id)
                .Index(t => t.Parent_Id);
            
            CreateTable(
                "dbo.ClothesParts",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(maxLength: 20),
                        CreateDT = c.DateTime(nullable: false),
                        ModifiedDT = c.DateTime(nullable: false),
                        IsDeleted = c.Boolean(nullable: false),
                        Parent_Id = c.Int(),
                        ClothType_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.ClothesParts", t => t.Parent_Id)
                .ForeignKey("dbo.ClothesTypes", t => t.ClothType_Id)
                .Index(t => t.Parent_Id)
                .Index(t => t.ClothType_Id);
            
            CreateTable(
                "dbo.ClothesPartTypes",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(maxLength: 100),
                        Order = c.Int(nullable: false),
                        ClothesPart_Id = c.Int(),
                        Parent_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.ClothesParts", t => t.ClothesPart_Id)
                .ForeignKey("dbo.ClothesPartTypes", t => t.Parent_Id)
                .Index(t => t.ClothesPart_Id)
                .Index(t => t.Parent_Id);
            
            CreateTable(
                "dbo.Clothes",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        SampleNO = c.String(maxLength: 50),
                        ProductNO = c.String(maxLength: 50),
                        ProductedCount = c.Int(nullable: false),
                        SaledCount = c.Int(nullable: false),
                        Comment = c.String(),
                        AssessoriesFile = c.String(maxLength: 100),
                        ClothesPics = c.String(maxLength: 500),
                        ModelVersionPics = c.String(maxLength: 500),
                        SampleFile = c.String(maxLength: 100),
                        StylePics = c.String(maxLength: 500),
                        TechnologyFile = c.String(maxLength: 100),
                        ClothesSize = c.String(maxLength: 1000),
                        Tags = c.String(maxLength: 1000),
                        ViewCount = c.Int(nullable: false),
                        Discriminator = c.String(nullable: false, maxLength: 128),
                        ClothesType_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.ClothesTypes", t => t.ClothesType_Id)
                .Index(t => t.ClothesType_Id);
            
            CreateTable(
                "dbo.UploadFiles",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Type = c.String(maxLength: 50),
                        Path = c.String(maxLength: 100),
                        CreateDT = c.DateTime(nullable: false),
                        ModifiedDT = c.DateTime(nullable: false),
                        IsDeleted = c.Boolean(nullable: false),
                        Clothes_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Clothes", t => t.Clothes_Id)
                .Index(t => t.Clothes_Id);
            
        }
        
        public override void Down()
        {
            DropIndex("dbo.UploadFiles", new[] { "Clothes_Id" });
            DropIndex("dbo.Clothes", new[] { "ClothesType_Id" });
            DropIndex("dbo.ClothesPartTypes", new[] { "Parent_Id" });
            DropIndex("dbo.ClothesPartTypes", new[] { "ClothesPart_Id" });
            DropIndex("dbo.ClothesParts", new[] { "ClothType_Id" });
            DropIndex("dbo.ClothesParts", new[] { "Parent_Id" });
            DropIndex("dbo.ClothesTypes", new[] { "Parent_Id" });
            DropIndex("dbo.SessionUsers", new[] { "UserId" });
            DropForeignKey("dbo.UploadFiles", "Clothes_Id", "dbo.Clothes");
            DropForeignKey("dbo.Clothes", "ClothesType_Id", "dbo.ClothesTypes");
            DropForeignKey("dbo.ClothesPartTypes", "Parent_Id", "dbo.ClothesPartTypes");
            DropForeignKey("dbo.ClothesPartTypes", "ClothesPart_Id", "dbo.ClothesParts");
            DropForeignKey("dbo.ClothesParts", "ClothType_Id", "dbo.ClothesTypes");
            DropForeignKey("dbo.ClothesParts", "Parent_Id", "dbo.ClothesParts");
            DropForeignKey("dbo.ClothesTypes", "Parent_Id", "dbo.ClothesTypes");
            DropForeignKey("dbo.SessionUsers", "UserId", "dbo.Users");
            DropTable("dbo.UploadFiles");
            DropTable("dbo.Clothes");
            DropTable("dbo.ClothesPartTypes");
            DropTable("dbo.ClothesParts");
            DropTable("dbo.ClothesTypes");
            DropTable("dbo.Users");
            DropTable("dbo.SessionUsers");
        }
    }
}
