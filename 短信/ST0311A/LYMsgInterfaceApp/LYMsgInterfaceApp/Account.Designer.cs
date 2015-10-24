namespace LYMsgInterfaceApp
{
    partial class Account
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.Spid = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.Com = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.ComName = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.LoginName = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.Password = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.QueryCNT = new System.Windows.Forms.TextBox();
            this.btnAccSubmit = new System.Windows.Forms.Button();
            this.btnAccClose = new System.Windows.Forms.Button();
            this.label7 = new System.Windows.Forms.Label();
            this.Aattribute = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(27, 178);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(63, 14);
            this.label1.TabIndex = 0;
            this.label1.Text = "企业号：";
            // 
            // Spid
            // 
            this.Spid.BackColor = System.Drawing.Color.MistyRose;
            this.Spid.Location = new System.Drawing.Point(95, 175);
            this.Spid.Name = "Spid";
            this.Spid.Size = new System.Drawing.Size(215, 23);
            this.Spid.TabIndex = 1;
            this.Spid.TextChanged += new System.EventHandler(this.Spid_TextChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(13, 33);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(77, 14);
            this.label2.TabIndex = 2;
            this.label2.Text = "公司编号：";
            // 
            // Com
            // 
            this.Com.BackColor = System.Drawing.Color.MistyRose;
            this.Com.Location = new System.Drawing.Point(95, 29);
            this.Com.Name = "Com";
            this.Com.Size = new System.Drawing.Size(215, 23);
            this.Com.TabIndex = 3;
            this.Com.TextChanged += new System.EventHandler(this.Com_TextChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(27, 136);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(63, 14);
            this.label3.TabIndex = 4;
            this.label3.Text = "企业名：";
            // 
            // ComName
            // 
            this.ComName.BackColor = System.Drawing.Color.MistyRose;
            this.ComName.Location = new System.Drawing.Point(95, 130);
            this.ComName.Name = "ComName";
            this.ComName.Size = new System.Drawing.Size(215, 23);
            this.ComName.TabIndex = 5;
            this.ComName.TextChanged += new System.EventHandler(this.ComName_TextChanged);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(27, 219);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(63, 14);
            this.label4.TabIndex = 6;
            this.label4.Text = "登陆名：";
            // 
            // LoginName
            // 
            this.LoginName.BackColor = System.Drawing.Color.MistyRose;
            this.LoginName.Location = new System.Drawing.Point(95, 220);
            this.LoginName.Name = "LoginName";
            this.LoginName.Size = new System.Drawing.Size(215, 23);
            this.LoginName.TabIndex = 7;
            this.LoginName.TextChanged += new System.EventHandler(this.LoginName_TextChanged);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(41, 266);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(49, 14);
            this.label5.TabIndex = 8;
            this.label5.Text = "密码：";
            // 
            // Password
            // 
            this.Password.BackColor = System.Drawing.Color.MistyRose;
            this.Password.Location = new System.Drawing.Point(95, 265);
            this.Password.Name = "Password";
            this.Password.PasswordChar = '*';
            this.Password.Size = new System.Drawing.Size(215, 23);
            this.Password.TabIndex = 9;
            this.Password.TextChanged += new System.EventHandler(this.Password_TextChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(41, 317);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(49, 14);
            this.label6.TabIndex = 10;
            this.label6.Text = "流量：";
            // 
            // QueryCNT
            // 
            this.QueryCNT.BackColor = System.Drawing.Color.MistyRose;
            this.QueryCNT.Location = new System.Drawing.Point(95, 310);
            this.QueryCNT.Name = "QueryCNT";
            this.QueryCNT.Size = new System.Drawing.Size(215, 23);
            this.QueryCNT.TabIndex = 11;
            this.QueryCNT.TextChanged += new System.EventHandler(this.QueryCNT_TextChanged);
            this.QueryCNT.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.QueryCNT_KeyPress);
            // 
            // btnAccSubmit
            // 
            this.btnAccSubmit.Location = new System.Drawing.Point(95, 361);
            this.btnAccSubmit.Name = "btnAccSubmit";
            this.btnAccSubmit.Size = new System.Drawing.Size(75, 23);
            this.btnAccSubmit.TabIndex = 12;
            this.btnAccSubmit.Text = "保存";
            this.btnAccSubmit.UseVisualStyleBackColor = true;
            this.btnAccSubmit.Click += new System.EventHandler(this.btnAccSubmit_Click);
            // 
            // btnAccClose
            // 
            this.btnAccClose.Location = new System.Drawing.Point(234, 360);
            this.btnAccClose.Name = "btnAccClose";
            this.btnAccClose.Size = new System.Drawing.Size(75, 23);
            this.btnAccClose.TabIndex = 13;
            this.btnAccClose.Text = "关闭";
            this.btnAccClose.UseVisualStyleBackColor = true;
            this.btnAccClose.Click += new System.EventHandler(this.btnAccClose_Click);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(13, 86);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(77, 14);
            this.label7.TabIndex = 14;
            this.label7.Text = "企业通道：";
            // 
            // Aattribute
            // 
            this.Aattribute.BackColor = System.Drawing.Color.White;
            this.Aattribute.FormattingEnabled = true;
            this.Aattribute.Location = new System.Drawing.Point(95, 83);
            this.Aattribute.Name = "Aattribute";
            this.Aattribute.Size = new System.Drawing.Size(215, 22);
            this.Aattribute.TabIndex = 15;
            // 
            // Account
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 14F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(347, 419);
            this.ControlBox = false;
            this.Controls.Add(this.Aattribute);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.btnAccClose);
            this.Controls.Add(this.btnAccSubmit);
            this.Controls.Add(this.QueryCNT);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.Password);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.LoginName);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.ComName);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.Com);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.Spid);
            this.Controls.Add(this.label1);
            this.Font = new System.Drawing.Font("宋体", 10.5F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.MaximizeBox = false;
            this.Name = "Account";
            this.Text = "帐号注册";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox Spid;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox Com;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox ComName;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox LoginName;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox Password;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox QueryCNT;
        private System.Windows.Forms.Button btnAccSubmit;
        private System.Windows.Forms.Button btnAccClose;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.ComboBox Aattribute;

        
    }
}