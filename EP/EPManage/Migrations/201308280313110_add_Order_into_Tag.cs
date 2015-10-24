namespace EPManageWeb.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class add_Order_into_Tag : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Tags", "Order", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Tags", "Order");
        }
    }
}
