package ep.org.clothingmaintenance.bean;

public class TTreeNode {
	private String deptid;
	private String name;
	private String enname;
	private boolean isParent=false;
	private String hasunFlag="0"; //"1"��ʾ���ӽڵ㣬"0"��ʾ���ӽڵ㡣
	private String loadDataFlag="0"; //"1"��ʾ��ݼ�����ɣ�"0"��ʾ���δ����,��JS�ж��Ƿ�Ҫ���������ʹ�á�
	private String isOpenFlag="0"; //"1"��ʾ�ڵ��Ѿ��򿪣�"0"��ʾδ�򿪣���JS�ж��ǽ���Ƿ��ʹ�á�
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDeptid() {
		return deptid;
	}
	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}
	public String getHasunFlag() {
		return hasunFlag;
	}
	public void setHasunFlag(String hasunFlag) {
		this.hasunFlag = hasunFlag;
	}
	public String getLoadDataFlag() {
		return loadDataFlag;
	}
	public void setLoadDataFlag(String loadDataFlag) {
		this.loadDataFlag = loadDataFlag;
	}
	public String getEnname() {
		return enname;
	}
	public void setEnname(String enname) {
		this.enname = enname;
	}
	public String getIsOpenFlag() {
		return isOpenFlag;
	}
	public void setIsOpenFlag(String isOpenFlag) {
		this.isOpenFlag = isOpenFlag;
	}
	public boolean getIsParent() {
		return isParent;
	}
	public void setIsParent(boolean isParent) {
		this.isParent = isParent;
	}
	
}
