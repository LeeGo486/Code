namespace EPManageWeb.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class add_user_type : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Users", "UserType", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.Users", "UserType");
        }
    }
}
