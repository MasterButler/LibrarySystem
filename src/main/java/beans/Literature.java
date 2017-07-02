package beans;

import java.util.ArrayList;
import java.util.Date;

import beans.list.NameList;

public class Literature extends LibraryObject{
	
	private long id;
	private String dds;
	
	private String title;
	private String type;
	private String publisher;
	private Date datePublished;
	private NameList authors;
	
	public Literature(){
		super();
		authors = new NameList();
	}
	
	public Date getDatePublished() {
		return datePublished;
	}

	public void setDatePublished(Date datePublished) {
		this.datePublished = datePublished;
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


	public void setAuthor(Name author) {
		this.authors.clear();
		this.authors.add(author);
	}
	
	public void setAuthors(NameList authorList) {
		this.authors.clear();
		this.authors.addAll(authorList);
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
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

	@Override
	public void setLibraryObjectType(int category) {
		this.libraryObjectType = category;
	}

	@Override
	public int getLibraryObjectType() {
		return libraryObjectType != 0 ? libraryObjectType : LibraryObjectTypes.DEFAULT.getValue();
	}
	
}
