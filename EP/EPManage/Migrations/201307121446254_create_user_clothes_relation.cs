namespace EPManageWeb.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class create_user_clothes_relation : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Users", "Department", c => c.String());
            AddColumn("dbo.Clothes", "Owner_Id", c => c.Int());
            AddForeignKey("dbo.Clothes", "Owner_Id", "dbo.Users", "Id");
            CreateIndex("dbo.Clothes", "Owner_Id");
        }
        
        public override void Down()
        {
            DropIndex("dbo.Clothes", new[] { "Owner_Id" });
            DropForeignKey("dbo.Clothes", "Owner_Id", "dbo.Users");
            DropColumn("dbo.Clothes", "Owner_Id");
            DropColumn("dbo.Users", "Department");
        }
    }
}
