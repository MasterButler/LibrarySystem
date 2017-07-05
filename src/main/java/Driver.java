import beans.list.LiteratureList;
import db.DBConnection;

public class Driver {
	public static void main(String[] args){
		DBConnection conn = new DBConnection();
		conn.connect();
		LiteratureList list = conn.getAllLiterature();
		for(int i = 0; i < list.size(); i++){
			System.out.println(list.get(i).getTitle());
		}
	}
}
