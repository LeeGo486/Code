namespace EPManageWeb.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class add_class_operationLog : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.OperationLogs",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        OperationType = c.String(),
                        CreateDT = c.DateTime(nullable: false),
                        ModifiedDT = c.DateTime(nullable: false),
                        IsDeleted = c.Boolean(nullable: false),
                        User_Id = c.Int(),
                        Clothes_Id = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Users", t => t.User_Id)
                .ForeignKey("dbo.Clothes", t => t.Clothes_Id)
                .Index(t => t.User_Id)
                .Index(t => t.Clothes_Id);
            
        }
        
        public override void Down()
        {
            DropIndex("dbo.OperationLogs", new[] { "Clothes_Id" });
            DropIndex("dbo.OperationLogs", new[] { "User_Id" });
            DropForeignKey("dbo.OperationLogs", "Clothes_Id", "dbo.Clothes");
            DropForeignKey("dbo.OperationLogs", "User_Id", "dbo.Users");
            DropTable("dbo.OperationLogs");
        }
    }
}
