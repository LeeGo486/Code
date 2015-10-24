namespace EPManageWeb.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class add_pinglei_to_clothes : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Clothes", "PingLei", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.Clothes", "PingLei");
        }
    }
}
