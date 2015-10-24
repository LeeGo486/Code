
function isDateString(sDate)
{	
	var iaMonthDays = [31,28,31,30,31,30,31,31,30,31,30,31]
	var iaDate = new Array(2)
	var year, month, day

	if (sDate.value.length != 5) return false

	iaDate[0]=sDate.value.substring(0,2)
	iaDate[1]=sDate.value.substring(3,5)
	
	month = parseFloat(iaDate[0])
	day=parseFloat(iaDate[1])


	if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1]=29;
	if (month < 1 || month > 12) return false
	if (day < 1 || day > iaMonthDays[month - 1]) return false
	return true	
}

function stringToDate(sDate)
{	
	var bValidDate, year, month, day
	var iaDate = new Array(3)

	bValidDate = isDateString(sDate)
	
	if (bValidDate)
	{  
		iaDate[0]=sDate.value.substring(0,4)
		iaDate[1]=sDate.value.substring(4,6)
		iaDate[2]=sDate.value.substring(6,8)
	
		year = parseFloat(iaDate[0])
		month = parseFloat(iaDate[1]) - 1
		day=parseFloat(iaDate[2])
		return (new Date(year,month,day))
	}
	else return (new Date(1900,1,1))
}
function checkOne(from)	//����
{	
	
	var returnvalue = true;
	var errorstr="";
	
	if(!isDateString(form.tbfrom))
	{
		returnvalue=false;
		errorstr+="��������ȷ���ڸ�ʽ\n MMDD\n";
	}
		if(!isDateString(form.tbTo))
	{
		returnvalue=false;
		errorstr+="��������ȷ���ڸ�ʽ\n MMDD\n";
	}

	var d = new Date();
	var s = d.getFullYear()+(d.getMonth()+1)+d.getDay();

	
	if (!returnvalue)
		alert(errorstr);
	return returnvalue;
}

function checkAll(form)
{
	var returnvalue = true;
	var errorstr="";
	//����

	if(form.triptype[0].checked)
	{
			
		if(!isDateString(form.takeoffDate1.value))
		{
			returnvalue=false
			errorstr+="��������ȷ���ڸ�ʽ\n YYYY-MM-DD\n";
		}
		var d = new Date();
		var s = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDay();
		if(stringToDate(form.takeoffDate1.value)<stringToDate(s))
		{
			returnvalue=false
			errorstr+="�������������Ч\n";
		}

	}
	//����
	else if(form.triptype[1].checked)
	{
		if(!isDateString(form.takeoffDate1.value) )
		{
			returnvalue=false;
			errorstr+="��������ȷ�ĳ�������\n YYYY-MM-DD\n";
		}
		if(!isDateString(form.takeoffDate2.value) )
		{
			returnvalue=false;
			errorstr+="��������ȷ�ķ�������\n YYYY-MM-DD\n";
		}
		if(stringToDate(form.takeoffDate1.value)<=new Date())
		{
			returnvalue=false
			errorstr+="�������������Ч\n";
		}
		if(form.startCode1.value=="non" || form.destinationCode1.value=="non")
		{
			returnvalue=false;
			errorstr+="��������������\n";
		}
		if(form.startCode1.value== form.destinationCode1.value)
		{
			returnvalue=false;
			errorstr+="����/������в�����ͬ\n";
		}
		if(stringToDate(form.takeoffDate2.value)<stringToDate(form.takeoffDate1.value))
		{
			returnvalue=false
			errorstr+="����ʱ�䲻�����ڳ���ʱ��\n";
		}
	}
	//���
	else if(form.triptype[2].checked)
	{
		if(!isDateString(form.takeoffDate1.value) )
		{
			returnvalue=false;
			errorstr+="��������ȷ�ĵ�һ��������\n YYYY-MM-DD\n";
		}
		if(!isDateString(form.takeoffDate2.value) )
		{
			returnvalue=false;
			errorstr+="��������ȷ�ĵڶ���������\n YYYY-MM-DD\n";
		}
		if(!isDateString(form.takeoffDate3.value) )
		{
			returnvalue=false;
			errorstr+="��������ȷ�ĵ�����������\n YYYY-MM-DD\n";
		}
		if(stringToDate(form.takeoffDate1.value)<=new Date())
		{
			returnvalue=false
			errorstr+="�������������Ч\n";
		}
		if(form.startCode1.value=="non" || form.destinationCode1.value=="non" || form.startCode2.value=="non" || form.startCode3.value=="non" || form.destinationCode2.value=="non" || form.destinationCode3.value=="non")
		{
			returnvalue=false;
			errorstr+="��������ȷ�ĳ���/�������\n";
		}
		if(form.startCode1.value== form.destinationCode1.value || form.startCode2.value== form.destinationCode2.value || form.startCode3.value== form.destinationCode3.value)
		{
			returnvalue=false;
			errorstr+="����/������в�����ͬ\n";
		}
		if(stringToDate(form.takeoffDate2.value)<stringToDate(form.takeoffDate1.value))
		{
			returnvalue=false;
			errorstr+="�ڶ��������ڲ������ڵ�һ��������\n";
		}
		if(stringToDate(form.takeoffDate3.value)<stringToDate(form.takeoffDate2.value))
		{
			returnvalue=false
			errorstr+="�����������ڲ������ڵڶ���������\n";
		}
	}
	if (!returnvalue)
		alert(errorstr);
	return returnvalue;
}