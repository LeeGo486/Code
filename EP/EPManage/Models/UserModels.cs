using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EPManageWeb.Models
{
    public class UserLoginModel
    {
        [Display(Name = "用户名")]
        public String UserName { get; set; }

        [Display(Name = "密码")]
        public String PassWord { get; set; }
    }

    public class UserChangePasswordModel
    {
        [Display(Name = "旧密码")]
        [Required]
        
        public String OldPassword { get; set; }

        [Display(Name = "新密码")]
        [Required]
        public String NewPassword { get; set; }
        
        [Display(Name = "确认新密码")]
        [Required]
        public String RetypeNewPassword { get; set; }
    }

    public class UserAddModel
    {
        [Display(Name = "用户名")]
        [Required]
        public String UserName { get; set; }

        [Display(Name = "真实姓名")]
        [Required]
        public String RealName { get; set; }

        [Display(Name = "部门")]
        [Required]
        public String Department { get; set; }
    }
}