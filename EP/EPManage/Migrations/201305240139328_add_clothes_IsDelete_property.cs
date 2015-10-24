namespace EPManageWeb.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class add_clothes_IsDelete_property : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Clothes", "CreateDT", c => c.DateTime(nullable: false));
            AddColumn("dbo.Clothes", "ModifiedDT", c => c.DateTime(nullable: false));
            AddColumn("dbo.Clothes", "IsDeleted", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Clothes", "IsDeleted");
            DropColumn("dbo.Clothes", "ModifiedDT");
            DropColumn("dbo.Clothes", "CreateDT");
        }
    }
}
