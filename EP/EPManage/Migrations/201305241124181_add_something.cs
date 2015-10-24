namespace EPManageWeb.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class add_something : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.Clothes", "Discriminator");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Clothes", "Discriminator", c => c.String(nullable: false, maxLength: 128));
        }
    }
}
