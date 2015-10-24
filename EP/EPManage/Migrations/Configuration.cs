namespace EPManageWeb.Migrations
{
    using EPManageWeb.Entities.Models;
    using System;
    using System.Collections.Generic;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<EPManageWeb.Entities.EPDataContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(EPManageWeb.Entities.EPDataContext context)
        {
            AddClothesTypes(context);
            AddUsers(context);
        }

        private void AddUsers(EPManageWeb.Entities.EPDataContext context)
        {
            if (context.Users.SingleOrDefault(t => t.UserName == "admin") == null)
            {
                context.Users.AddOrUpdate(new User() { Id = 1, UserName = "admin", Password = "admin", UserType = UserType.Admin.ToString(), CreateDT = DateTime.Now, ModifiedDT = DateTime.Now, RealName = "王利峰" });
            }
            if (context.Users.SingleOrDefault(t => t.UserName == "user") == null)
            {
                context.Users.AddOrUpdate(new User() { UserName = "user", Password = "user", UserType = UserType.User.ToString(), CreateDT = DateTime.Now, ModifiedDT = DateTime.Now, RealName = "普通用户" });
            }
        }

        private void AddClothesTypes(EPManageWeb.Entities.EPDataContext context)
        {
            AddClothType_ShangZhuang(context);
            // AddClothType_XiaZhuang(context);

            if (context.ClothesTypes.Count(t => t.Name == "下装") == 0)
            {
                context.ClothesTypes.Add(new ClothesType()
                {
                    Name = "下装",
                    Children = new List<ClothesType>
                    {
                       new ClothesType(){ Name="裙子",
                        ClothesParts = new List<ClothesPart>
                        {
                         new ClothesPart(){ Name="裙身",  Children=new List<ClothesPart>
                         {
                              new ClothesPart(){ Name="廓形",
                                  PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="直身裙"},
                                      new ClothesPartType(){ Name="A字裙"},
                                      new ClothesPartType(){ Name="波浪"}
                                }
                              },
                              new ClothesPart(){ Name="宽松风格",
                                   PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="宽松(H>98)"},
                                      new ClothesPartType(){ Name="较宽松（H=93~98）"},
                                      new ClothesPartType(){ Name="贴体（H=88~93）"}
                                }
                              },
                              new ClothesPart(){ Name="裙长",
                                   PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="3分"},
                                      new ClothesPartType(){ Name="4分"},
                                      new ClothesPartType(){ Name="5分"},
                                      new ClothesPartType(){ Name="6~7分"},
                                      new ClothesPartType(){ Name="8~9分"},
                                      new ClothesPartType(){ Name="10分"}

                                }
                              },
                               new ClothesPart(){ Name="造型特征",
                                   PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="分割",
                                          Children=new List<ClothesPartType>
                                         {
                                               new ClothesPartType(){ Name="横向"},
                                               new ClothesPartType(){ Name="纵向"},
                                               new ClothesPartType(){ Name="不规则"}
                                         }
                                      },
                                          new ClothesPartType(){ Name="省道"},
                                          new ClothesPartType(){ Name="折裥"},
                                          new ClothesPartType(){ Name="抽褶"}
                                }
                              }
                         }
                                     },
                         new ClothesPart(){ Name="腰头", Children=new List<ClothesPart>
                         {
                              new ClothesPart(){ Name="腰高",
                                  PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="低腰"},
                                      new ClothesPartType(){ Name="中腰"},
                                      new ClothesPartType(){ Name="高腰"}
                                }
                              },
                              new ClothesPart(){ Name="工艺",
                                   PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="装腰"},
                                      new ClothesPartType(){ Name="连腰"},
                                      new ClothesPartType(){ Name="约克"}
                                }
                              }
                         }
                                     }
                         }



                       },
                       new ClothesType(){ Name="裤子",
                              ClothesParts = new List<ClothesPart>
                        {
                         new ClothesPart(){ Name="裤身", Children=new List<ClothesPart>
                         {
                              new ClothesPart(){ Name="廓形",
                                  PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="直筒裤"},
                                      new ClothesPartType(){ Name="窄脚裤"},
                                      new ClothesPartType(){ Name="喇叭裤"},
                                      new ClothesPartType(){ Name="哈伦裤"}
                                }
                              },
                              new ClothesPart(){ Name="宽松风格",
                                   PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="宽松(H>98)"},
                                      new ClothesPartType(){ Name="较宽松（H=93~98）"},
                                      new ClothesPartType(){ Name="贴体（H=88~93）"}
                                }
                              },
                              new ClothesPart(){ Name="裙长",
                                   PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="3分"},
                                      new ClothesPartType(){ Name="4分"},
                                      new ClothesPartType(){ Name="5分"},
                                      new ClothesPartType(){ Name="6~7分"},
                                      new ClothesPartType(){ Name="8~9分"},
                                      new ClothesPartType(){ Name="10分"}

                                }
                              },
                               new ClothesPart(){ Name="造型特征",
                                   PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="分割",
                                          Children=new List<ClothesPartType>
                                         {
                                               new ClothesPartType(){ Name="横向"},
                                               new ClothesPartType(){ Name="纵向"},
                                               new ClothesPartType(){ Name="不规则"}
                                         }
                                      },
                                          new ClothesPartType(){ Name="省道"},
                                          new ClothesPartType(){ Name="折裥"},
                                          new ClothesPartType(){ Name="抽褶"}
                                }
                              }
                         }
                                     },
                         new ClothesPart(){ Name="腰头", Children=new List<ClothesPart>
                         {
                              new ClothesPart(){ Name="腰高",
                                  PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="低腰"},
                                      new ClothesPartType(){ Name="中腰"},
                                      new ClothesPartType(){ Name="高腰"}
                                }
                              },
                              new ClothesPart(){ Name="工艺",
                                   PartTypes=new List<ClothesPartType>
                               {
                                      new ClothesPartType(){ Name="装腰"},
                                      new ClothesPartType(){ Name="连腰"},
                                      new ClothesPartType(){ Name="约克"}
                                }
                              }
                         }
                                     }
                         }



                       }
                    }
                });
            }

            //if (context.ClothesTypes.Count(t => t.Name == "毛衫") == 0)
            //{
            //    context.ClothesTypes.Add(new ClothesType() { Name = "毛衫" });
            //}
        }

        private void AddClothType_ShangZhuang(EPManageWeb.Entities.EPDataContext context)
        {
            if (context.ClothesTypes.Count(t => t.Name == "上装") == 0)
            {

                ClothesType c = new ClothesType() { Name = "上装" };
                c.ClothesParts = new List<ClothesPart>();
                var p = new ClothesPart() { Name = "品类", ClothType = c };
                p.PartTypes = new List<ClothesPartType>();
                p.PartTypes.Add(new ClothesPartType() { Name = "外套", ClothesPart = p });
                p.PartTypes.Add(new ClothesPartType() { Name = "衬衫", ClothesPart = p });
                p.PartTypes.Add(new ClothesPartType() { Name = "小衫", ClothesPart = p });
                p.PartTypes.Add(new ClothesPartType() { Name = "风衣", ClothesPart = p });
                p.PartTypes.Add(new ClothesPartType() { Name = "大衣", ClothesPart = p });
                p.PartTypes.Add(new ClothesPartType() { Name = "棉衣/羽绒服", ClothesPart = p });
                p.PartTypes.Add(new ClothesPartType() { Name = "皮衣", ClothesPart = p });
                p.PartTypes.Add(new ClothesPartType() { Name = "连衣裙", ClothesPart = p });
                c.ClothesParts.Add(p);

                var p1 = new ClothesPart() { Name = "衣身", ClothType = c };
                p1.Children = new List<ClothesPart>();

                var p11 = new ClothesPart() { Name = "廓形", Parent = p1 };
                p11.PartTypes = new List<ClothesPartType>();
                p11.PartTypes.Add(new ClothesPartType() { Name = "H", ClothesPart = p11 });
                p11.PartTypes.Add(new ClothesPartType() { Name = "X", ClothesPart = p11 });
                p11.PartTypes.Add(new ClothesPartType() { Name = "A", ClothesPart = p11 });
                p11.PartTypes.Add(new ClothesPartType() { Name = "O", ClothesPart = p11 });
                p1.Children.Add(p11);

                var p12 = new ClothesPart() { Name = "宽松风格", Parent = p1 };
                p12.PartTypes = new List<ClothesPartType>();
                p12.PartTypes.Add(new ClothesPartType() { Name = "宽松(B>105)", ClothesPart = p12 });
                p12.PartTypes.Add(new ClothesPartType() { Name = "较宽松(B=95~105)", ClothesPart = p12 });
                p12.PartTypes.Add(new ClothesPartType() { Name = "贴体(B=84~95)", ClothesPart = p12 });
                p1.Children.Add(p12);

                var p13 = new ClothesPart() { Name = "片数", Parent = p1 };
                p13.PartTypes = new List<ClothesPartType>();
                p13.PartTypes.Add(new ClothesPartType() { Name = "2开身", ClothesPart = p13 });
                p13.PartTypes.Add(new ClothesPartType() { Name = "3开身", ClothesPart = p13 });
                p13.PartTypes.Add(new ClothesPartType() { Name = "4开身", ClothesPart = p13 });
                p13.PartTypes.Add(new ClothesPartType() { Name = "多开身", ClothesPart = p13 });
                p1.Children.Add(p13);

                var p14 = new ClothesPart() { Name = "造型特征", Parent = p1 };
                p14.PartTypes = new List<ClothesPartType>();
                p14.PartTypes.Add(new ClothesPartType() { Name = "分割", ClothesPart = p14 });
                p14.PartTypes.Add(new ClothesPartType() { Name = "省道", ClothesPart = p14 });
                p14.PartTypes.Add(new ClothesPartType() { Name = "折裥", ClothesPart = p14 });
                p14.PartTypes.Add(new ClothesPartType() { Name = "抽摺", ClothesPart = p14 });
                p14.PartTypes.Add(new ClothesPartType() { Name = "约克", ClothesPart = p14 });
                p1.Children.Add(p14);

                c.ClothesParts.Add(p1);

                var p2 = new ClothesPart() { Name = "领型", ClothType = c };
                p2.PartTypes = new List<ClothesPartType>();
                p2.PartTypes.Add(new ClothesPartType() { Name = "无领", ClothesPart = p2 });
                p2.PartTypes.Add(new ClothesPartType() { Name = "圆领", ClothesPart = p2 });
                p2.PartTypes.Add(new ClothesPartType() { Name = "驳折领", ClothesPart = p2 });
                p2.PartTypes.Add(new ClothesPartType() { Name = "连帽子", ClothesPart = p2 });
                p2.PartTypes.Add(new ClothesPartType() { Name = "翻折领", ClothesPart = p2 });
                c.ClothesParts.Add(p2);

                var p3 = new ClothesPart() { Name = "衣袖", ClothType = c };
                p3.Children = new List<ClothesPart>();

                var p31 = new ClothesPart() { Name = "袖型", Parent = p3 };
                p31.PartTypes = new List<ClothesPartType>();
                p31.PartTypes.Add(new ClothesPartType() { Name = "装袖", ClothesPart = p31 });
                p31.PartTypes.Add(new ClothesPartType() { Name = "无袖", ClothesPart = p31 });
                p31.PartTypes.Add(new ClothesPartType() { Name = "连身袖", ClothesPart = p31 });
                p31.PartTypes.Add(new ClothesPartType() { Name = "插肩袖", ClothesPart = p31 });
                p3.Children.Add(p31);

                var p32 = new ClothesPart() { Name = "片数", Parent = p3 };
                p32.PartTypes = new List<ClothesPartType>();
                p32.PartTypes.Add(new ClothesPartType() { Name = "一片", ClothesPart = p32 });
                p32.PartTypes.Add(new ClothesPartType() { Name = "两片", ClothesPart = p32 });
                p32.PartTypes.Add(new ClothesPartType() { Name = "多片", ClothesPart = p32 });
                p3.Children.Add(p32);

                var p33 = new ClothesPart() { Name = "长短", Parent = p3 };
                p33.PartTypes = new List<ClothesPartType>();
                p33.PartTypes.Add(new ClothesPartType() { Name = "无袖", ClothesPart = p33 });
                p33.PartTypes.Add(new ClothesPartType() { Name = "短袖", ClothesPart = p33 });
                p33.PartTypes.Add(new ClothesPartType() { Name = "五分袖", ClothesPart = p33 });
                p33.PartTypes.Add(new ClothesPartType() { Name = "七分袖", ClothesPart = p33 });
                p33.PartTypes.Add(new ClothesPartType() { Name = "长袖", ClothesPart = p33 });
                p3.Children.Add(p33);

                var p34 = new ClothesPart() { Name = "造型特征", Parent = p3 };
                p34.PartTypes = new List<ClothesPartType>();
                p34.PartTypes.Add(new ClothesPartType() { Name = "直身袖", ClothesPart = p34 });
                p34.PartTypes.Add(new ClothesPartType() { Name = "弯身袖", ClothesPart = p34 });
                p34.PartTypes.Add(new ClothesPartType() { Name = "泡泡袖", ClothesPart = p34 });
                p34.PartTypes.Add(new ClothesPartType() { Name = "喇叭袖", ClothesPart = p34 });
                p34.PartTypes.Add(new ClothesPartType() { Name = "蝙蝠袖", ClothesPart = p34 });
                p34.PartTypes.Add(new ClothesPartType() { Name = "羊腿袖", ClothesPart = p34 });
                p34.PartTypes.Add(new ClothesPartType() { Name = "灯笼袖", ClothesPart = p34 });
                p3.Children.Add(p34);

                c.ClothesParts.Add(p3);
                context.ClothesTypes.Add(c);

            }
        }
    }
}
