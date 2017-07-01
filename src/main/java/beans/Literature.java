package beans;

import java.util.ArrayList;
import java.util.Date;

public class Literature {
	
	private long id;
	
	private Date date;
	private String dds;
	
	private String title;
	private String type;
	private String publisher;
	private ArrayList<Name> authors;
	
	private int category;
	
	public Literature(){
		authors = new ArrayList<Name>();
	}
	
	public boolean addAuthor(Name name){
		if(this.authors.add(name)){
			return true;
		};
		return false;
	}
	
	public boolean addAuthors(ArrayList<Name> names){
		if(this.authors.addAll(names)){
			return true;
		}
		return false;
	}
	
	public ArrayList<Name> getAuthors() {
		return authors;
	}

	public void setAuthors(ArrayList<Name> author) {
		this.authors = authors;
	}

	public int getCategory() {
		return category != 0 ? category : LibraryObjectTypes.DEFAULT.getValue();
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getDds() {
		return dds;
	}

	public void setDds(String dds) {
		this.dds = dds;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	
	
}
