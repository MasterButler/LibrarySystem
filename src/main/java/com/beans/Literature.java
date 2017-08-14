package com.beans;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.beans.list.NameList;
import com.beans.list.ReviewList;
import com.beans.user.User;
import com.beans.user.UserTypes;

public class Literature extends LibraryObject{
	
	public static final int FIELD_ALL = 0;
	public static final int FIELD_TITLE = 1;
	public static final int FIELD_AUTHOR = 2;
	public static final int FIELD_PUBLISHER= 3;
	
	public static final int CATEGORY_ALL = 0;
	public static final int CATEGORY_BOOKS = 0;
	public static final int CATEGORY_THESIS = 0;
	public static final int CATEGORY_MAGAZINES = 0;
	
	private String dds;
	
	private String title;
	private String publisher;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date datePublished;
	private NameList authors;
	
	private ReviewList reviews;
	
	public Literature(){
		super();
        status = new Status();
		authors = new NameList();
		reviews = new ReviewList();
	}
	
    public boolean isBorrowable(){
        if(status.getAvailability() == Status.STATUS_AVAILABLE)
            return true;
        return false;
    }
    
    public boolean isBorrowable(User user){
    	if(status.getAvailability() == Status.STATUS_AVAILABLE || 
    		status.getAvailability() == status.STATUS_RESERVED && user.getUserType() == UserTypes.LIBRARY_MANAGER.getValue()){
    		return true;
    	}
    	return false;
    }
    
    public boolean isNotOut(){
        if(status.getAvailability() != Status.STATUS_OUT){
            return true;
        }
        return false;
    }
    
    public void setStatus(Status status){
        this.status = status;
    }
    
    public Status getStatus(){
        return this.status;
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
	
	public NameList getAuthors() {
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
	
	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	@Override
	public void setLibraryObjectType(int libraryObjectType) {
		this.libraryObjectType = libraryObjectType;
	}

	@Override
	public int getLibraryObjectType() {
		return libraryObjectType;
	}
	
	public boolean addReview(Review review){
		if(reviews.add(review)){
			return true;
		}
		return false;
	}

	public ReviewList getReviews() {
		return reviews;
	}

	public void setReviews(ReviewList reviews) {
		this.reviews = reviews;
	}


}
