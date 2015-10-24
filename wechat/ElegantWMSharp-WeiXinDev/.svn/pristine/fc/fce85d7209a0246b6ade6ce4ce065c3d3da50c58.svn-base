using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Drawing.Imaging;

namespace ElegantWM.Tools
{
    /// <summary>
    /// 生成验证码的类
    /// </summary>
    public class ValidateNumberHelper
    {
        public static void DrawImage()
        {
            ValidateNumberHelper img = new ValidateNumberHelper();
            HttpContext.Current.Session["CheckCode"] = img.RndNum(4);
            img.CreateImages(HttpContext.Current.Session["CheckCode"].ToString());
        }
        /// <summary>
        /// 生成验证图片
        /// </summary>
        /// <param name="checkCode">验证字符</param>
        private void CreateImages(string checkCode)
        {
            int iwidth = (int)(checkCode.Length * 17);
            System.Drawing.Bitmap image = new System.Drawing.Bitmap(iwidth, 25);
            Graphics g = Graphics.FromImage(image);
            g.Clear(Color.White);
            //定义颜色
            Color[] c = { Color.Black, Color.Red, Color.DarkBlue, Color.Green, Color.Orange, Color.Brown, Color.DarkCyan, Color.Purple };
            //定义字体 
            string[] font = { "Verdana", "Microsoft Sans Serif", "Comic Sans MS", "Arial", "宋体" };
            Random rand = new Random();
            //随机输出噪点
            for (int i = 0; i < 50; i++)
            {
                int x = rand.Next(image.Width);
                int y = rand.Next(image.Height);
                g.DrawRectangle(new Pen(Color.LightGray, 0), x, y, 1, 1);
            }

            //输出不同字体和颜色的验证码字符
            for (int i = 0; i < checkCode.Length; i++)
            {
                int cindex = rand.Next(7);
                int findex = rand.Next(5);

                Font f = new System.Drawing.Font(font[findex], 14, System.Drawing.FontStyle.Bold);
                Brush b = new System.Drawing.SolidBrush(c[cindex]);
                int ii = 4;
                if ((i + 1) % 2 == 0)
                {
                    ii = 2;
                }
                g.DrawString(checkCode.Substring(i, 1), f, b, 3 + (i * 12), ii);
            }
            //画一个边框
            g.DrawRectangle(new Pen(Color.Black, 0), 0, 0, image.Width - 1, image.Height - 1);

            //输出到浏览器
            System.IO.MemoryStream ms = new System.IO.MemoryStream();
            image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
            HttpContext.Current.Response.ClearContent();
            //Response.ClearContent();
            HttpContext.Current.Response.ContentType = "image/Jpeg";
            HttpContext.Current.Response.BinaryWrite(ms.ToArray());
            g.Dispose();
            image.Dispose();
        }
        /// <summary>
        /// 生成随机的字母
        /// </summary>
        /// <param name="VcodeNum">生成字母的个数</param>
        /// <returns>string</returns>
        private string RndNum(int VcodeNum)
        {
            string Vchar = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,J,K,M,N,P,Q,R,S,T,U,V,W,X,Y,Z";
            string[] VcArray = Vchar.Split(',');
            string VNum = ""; //由于字符串很短，就不用StringBuilder了
            int temp = -1; //记录上次随机数值，尽量避免生产几个一样的随机数

            //采用一个简单的算法以保证生成随机数的不同
            Random rand = new Random();
            for (int i = 1; i < VcodeNum + 1; i++)
            {
                if (temp != -1)
                {
                    rand = new Random(i * temp * unchecked((int)DateTime.Now.Ticks));
                }
                int t = rand.Next(VcArray.Length);
                if (temp != -1 && temp == t)
                {
                    return RndNum(VcodeNum);
                }
                temp = t;
                VNum += VcArray[t];
            }
            return VNum;
        }





        //绘图
        /// <summary>
        ///  FindPace.ValidateNumberHelper.DrawValidateCode 
        ///  (FindPace.ValidateNumberHelper.ValidateCode(5),50,100);
        ///  
        /// </summary>
        /// <param name="strValidateCode"></param>
        /// <param name="intFgNoise"></param>
        /// <param name="intBgNoise"></param>
        public static void DrawValidateCode(string strValidateCode, int intFgNoise, int intBgNoise)
        {
            if (strValidateCode == null || strValidateCode.Trim() == String.Empty)
            {
                return;
            }
            else
            {
                //建立一个位图文件 确立长宽
                Bitmap bmpImage = new Bitmap((int)Math.Ceiling((strValidateCode.Length * 12.5)), 22);
                Graphics grpGraphics = Graphics.FromImage(bmpImage);

                try
                {
                    //生成随机生成器
                    Random rndRandom = new Random();

                    //清空图片背景色
                    grpGraphics.Clear(Color.White);

                    //画图片的背景噪音线
                    for (int i = 0; i < intBgNoise; i++)
                    {
                        int int_x1 = rndRandom.Next(bmpImage.Width);
                        int int_x2 = rndRandom.Next(bmpImage.Width);
                        int int_y1 = rndRandom.Next(bmpImage.Height);
                        int int_y2 = rndRandom.Next(bmpImage.Height);

                        grpGraphics.DrawLine(new Pen(Color.Silver), int_x1, int_y1, int_x2, int_y2);
                    }
                    //把产生的随机数以字体的形式写入画面
                    Font font = new Font("Arial", 12, (FontStyle.Bold | FontStyle.Italic));
                    LinearGradientBrush brhBrush = new LinearGradientBrush(new Rectangle(0, 0, bmpImage.Width, bmpImage.Height), Color.Blue, Color.DarkRed, 1.2f, true);
                    grpGraphics.DrawString(strValidateCode, font, brhBrush, 2, 2);

                    //画图片的前景噪音点
                    for (int i = 0; i < intFgNoise; i++)
                    {
                        int int_x = rndRandom.Next(bmpImage.Width);
                        int int_y = rndRandom.Next(bmpImage.Height);

                        bmpImage.SetPixel(int_x, int_y, Color.FromArgb(rndRandom.Next()));
                    }

                    //画图片的边框线
                    grpGraphics.DrawRectangle(new Pen(Color.Silver), 0, 0, bmpImage.Width - 1, bmpImage.Height - 1);

                    MemoryStream memsMemoryStream = new MemoryStream();
                    bmpImage.Save(memsMemoryStream, ImageFormat.Gif);
                    HttpContext.Current.Response.ClearContent();
                    HttpContext.Current.Response.ContentType = "image/Gif";
                    HttpContext.Current.Response.BinaryWrite(memsMemoryStream.ToArray());
                }
                finally
                {
                    grpGraphics.Dispose();
                    bmpImage.Dispose();
                }
            }
        }

        //取得随机字符串，并设置Session值
        public static string ValidateCode(int intLength)
        {
            int intNumber;
            char chrCode;
            string strValidateCode = String.Empty;

            Random rndRandom = new Random();

            for (int i = 0; i < intLength; i++)
            {
                intNumber = rndRandom.Next();
                if (intNumber % 2 == 0)
                {
                    chrCode = (char)('0' + (char)(intNumber % 10));//如果随机数是偶数 取余
                }
                else
                {
                    chrCode = (char)('A' + (char)(intNumber % 26));//如果随机数是奇数 选择从[A-Z]
                }
                strValidateCode += chrCode.ToString();
            }

            HttpContext.Current.Session["CheckCode"] = strValidateCode;//设置Session["ValidateCode"]

            return strValidateCode;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static string CreatValidateCode()
        {
            Encoding gb = Encoding.GetEncoding("gb2312");
            string[] storecode = new String[16] { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };
            Random rnd = new Random();
            object[] codes = new object[4];
            for (int i = 0; i < 4; i++)
            {
                int rcode1 = rnd.Next(11, 14);
                string str_rcode1 = storecode[rcode1].Trim();
                rnd = new Random(rcode1 * unchecked((int)DateTime.Now.Ticks) + i);
                int rcode2;
                if (rcode1 == 13)
                {
                    rcode2 = rnd.Next(0, 7);
                }
                else
                {
                    rcode2 = rnd.Next(0, 16);
                }
                string str_rcode2 = storecode[rcode2].Trim();
                rnd = new Random(rcode2 * unchecked((int)DateTime.Now.Ticks) + i);
                int rcode3 = rnd.Next(10, 16);
                string str_rcode3 = storecode[rcode3].Trim();
                rnd = new Random(rcode3 * unchecked((int)DateTime.Now.Ticks) + i);
                int rcode4;
                if (rcode3 == 10)
                {
                    rcode4 = rnd.Next(1, 16);
                }
                else if (rcode3 == 15)
                {
                    rcode4 = rnd.Next(0, 15);
                }
                else
                {
                    rcode4 = rnd.Next(0, 16);
                }
                string str_rcode4 = storecode[rcode4].Trim();
                byte byte1 = Convert.ToByte(str_rcode1 + str_rcode2, 16);
                byte byte2 = Convert.ToByte(str_rcode3 + str_rcode4, 16);
                byte[] storebytes = new byte[] { byte1, byte2 };
                codes.SetValue(storebytes, i);

            }

            object[] showbytes = codes;
            string strcode1 = gb.GetString((byte[])Convert.ChangeType(showbytes[0], typeof(byte[])));
            string strcode2 = gb.GetString((byte[])Convert.ChangeType(showbytes[1], typeof(byte[])));
            string strcode3 = gb.GetString((byte[])Convert.ChangeType(showbytes[2], typeof(byte[])));
            string strcode4 = gb.GetString((byte[])Convert.ChangeType(showbytes[3], typeof(byte[])));
            string checkValidateCode = strcode1 + strcode2 + strcode3 + strcode4;
            HttpContext.Current.Session["CheckCode"] = checkValidateCode;
            // HttpContext.Current.Response.Cookies.Add(new HttpCookie("ValidateCode", checkValidateCode));
            return checkValidateCode;
        }

        /// <summary>
        /// FindPace.ValidateNumberHelper.CreateImage(FindPace.ValidateNumberHelper.CreatValidateCode());
        /// </summary>
        /// <param name="checkValidateCode"></param>
        public static void CreateImage(string checkValidateCode)
        {
            if (checkValidateCode == null || checkValidateCode.Trim() == String.Empty)
                return;

            System.Drawing.Bitmap image = new System.Drawing.Bitmap((int)Math.Ceiling((checkValidateCode.Length * 45.0)), 80);
            Graphics g = Graphics.FromImage(image);

            try
            {
                Random random = new Random();
                g.Clear(Color.White);
                for (int i = 0; i < 150; i++)
                {
                    int x1 = random.Next(image.Width);
                    int x2 = random.Next(image.Width);
                    int y1 = random.Next(image.Height);
                    int y2 = random.Next(image.Height);

                    g.DrawLine(new Pen(Color.Silver), x1, y1, x2, y2);
                }

                string[] pickfonts = { "Verdana", "Microsoft Sans Serif", "Comic Sans MS", "Arial", "宋体" };
                Color[] pickcolors = { Color.Black, Color.Red, Color.DarkBlue, Color.Green, Color.Orange, Color.Brown, Color.DarkCyan, Color.Purple };
                for (int i = 0; i < checkValidateCode.Length; i++)
                {
                    int pickindex = random.Next(7);
                    int fontindex = random.Next(4);

                    Font font_f = new System.Drawing.Font(pickfonts[fontindex], 15, System.Drawing.FontStyle.Bold);
                    Brush solid_b = new System.Drawing.SolidBrush(pickcolors[pickindex]);
                    int j = 30;
                    if ((i + 1) % 2 == 0)
                    {
                        j = 2;
                    }
                    g.DrawString(checkValidateCode.Substring(i, 1), font_f, solid_b, 3 + (i * 20), j);
                }

                for (int i = 0; i < 1000; i++)
                {
                    int x = random.Next(image.Width);
                    int y = random.Next(image.Height);

                    image.SetPixel(x, y, Color.FromArgb(random.Next()));
                }
                g.DrawRectangle(new Pen(Color.Silver), 0, 0, image.Width - 1, image.Height - 1);

                System.IO.MemoryStream ms = new System.IO.MemoryStream();
                image.Save(ms, System.Drawing.Imaging.ImageFormat.Bmp);
                HttpContext.Current.Response.ClearContent();
                HttpContext.Current.Response.ContentType = "image/Bmp";
                HttpContext.Current.Response.BinaryWrite(ms.ToArray());
            }
            finally
            {
                g.Dispose();
                image.Dispose();
            }
        }
    }

}
