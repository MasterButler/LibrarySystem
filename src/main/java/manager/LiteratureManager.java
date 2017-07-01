package manager;

import beans.Literature;
import date.DateUtil;

public class LiteratureManager {

	public void searchBook(){
		//TODO Search book
	}
	
	public static Literature createLiterature(String date, String dds, String title, String type, String publisher){
		Literature lit = new Literature();
		lit.setDate(DateUtil.readDateFromString(date));
		lit.setTitle(title);
		lit.setType(type);
		lit.setPublisher(publisher);
		
		return lit;
	}
}
