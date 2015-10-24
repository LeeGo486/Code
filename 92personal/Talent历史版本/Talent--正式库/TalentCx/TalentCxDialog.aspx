﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalentCxDialog.aspx.cs" Inherits="Talent.Web.TalentCx.TalentCxDialog" %>

<div class="pageContent">
	<form method="post" action="TalentCx/TalentCx.aspx" class="pageForm" onsubmit="return navTabSearch(this,'TalentCx');">
		<div class="pageFormContent" layoutH="58">
			<div class="unit">
				<label>公司名称：</label>
				<input type="text" size="25" name="CB_Name" />
			</div>
			<div class="unit">
				<label>公司所在地：</label>
				<input type="text" size="25" name="CB_Position"/>
			</div>
            <div class="unit">
				<label>行业：</label>
				<input type="text" size="25" name="TI_Industry"/>
			</div>
			<div class="unit">
				<label>人才类别：</label>
                <input type="text" size="25" name="TI_TalentClass"/>
			</div>
            <div class="divider">divider</div>
			<div class="unit">
				<label>姓名：</label>
				<input type="text" size="25" name="TI_Name"/>
			</div>
            <div class="unit">
				<label>性别：</label>
                <select name="TI_Sex">
                    <option></option>
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
			</div>
            <div class="unit">
				<label>工作经历：</label>
				<input type="text" size="25" name="TI_Work" />
			</div>
            <div class="unit">
				<label>来源：</label>
				<input type="text" size="25" name="TI_Src" />
			</div>
            <div class="unit">
				<label>推荐人：</label>
				<input type="text" size="25" name="TI_Recommend" />
			</div>
            <div class="divider">divider</div>
			<div class="unit">
				<label>是否面试：</label>
                <select name="TI_Audition">
                    <option></option>
                    <option value="是">是</option>
                    <option value="否">否</option>
                </select>
			</div>
			<div class="unit">
				<label>面试结果：</label>
				<input type="text" size="25" name="TI_AuditionResult"/>
			</div>
			<div class="unit">
				<label>跟进人：</label>
				<input type="text" size="25" name="TI_FollowUpPeople" />
			</div>
			<div class="unit">
				<label>推荐岗位：</label>
				<input type="text" size="25" name="TI_RecommendPost" />
			</div>
            <div class="unit">
				<label>特点：</label>
				<input type="text" size="25" name="TI_Mark" />
			</div>
			<div class="divider">divider</div>

		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit" >开始检索</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="reset">清空重输</button></div></div></li>
			</ul>
		</div>
	</form>
</div>

