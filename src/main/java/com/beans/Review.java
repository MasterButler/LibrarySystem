 package com.beans;

import com.beans.user.User;

public class Review {
	private String description;
	private Literature reviewDoneFor;
	private User reviewDoneBy;
	private int id;
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	public Literature getReviewDoneFor() {
		return reviewDoneFor;
	}
	public void setReviewDoneFor(Literature reviewDoneFor) {
		this.reviewDoneFor = reviewDoneFor;
	}
	public User getReviewDoneBy() {
		return reviewDoneBy;
	}
	public void setReviewDoneBy(User reviewDoneBy) {
		this.reviewDoneBy = reviewDoneBy;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
}
