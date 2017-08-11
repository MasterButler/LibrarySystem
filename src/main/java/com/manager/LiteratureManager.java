package com.manager;

import com.beans.LibraryObject;
import com.beans.LibraryObjectTypes;
import com.beans.Literature;
import com.beans.Name;
import com.beans.Status;
import com.beans.list.LiteratureList;
import com.beans.list.NameList;
import com.beans.user.User;
import com.db.DBConnection;
import com.handler.TextHandler;
import com.util.DateUtil;

public class LiteratureManager {
	private static volatile LiteratureManager instance;

	private static LiteratureList literatureList;
	
	private LiteratureManager(){
		
	}
	
	public static LiteratureManager getInstance(){
		if(instance == null){
			instance = new LiteratureManager();
			
			literatureList = new DBConnection().getAllLiterature();
			
			
			/*literatureList = new LiteratureList();
			Name authorA = new Name("Mahou", "Papua", "Eksdi");
			Name authorB = new Name("Will", "Thea", "Powers");
			Name authorC = new Name("Fee", "Fokin", "Shing");

			NameList authorsA = new NameList();
			NameList authorsB = new NameList();
			NameList authorsC = new NameList();
			authorsA.add(authorA);
			authorsB.add(authorB);
			authorsC.add(authorC);

			Status statusA = new Status();
			Status statusB = new Status();
			Status statusC = new Status();
			Status statusD = new Status();
			Status statusE = new Status();
			Status statusF = new Status();
			Status statusG = new Status();
			
			
			literatureList.add(createLiterature("0", "111", "The book of magic", LibraryObjectTypes.BOOK.getValue(), "Felicia and Co.", "2011-01-12 0:0:0", authorsA, statusA));
			literatureList.add(createLiterature("1", "112", "The book of power", LibraryObjectTypes.MAGAZINE.getValue(), "Alicia and Co.", "2012-05-12 0:0:0", authorsB, statusB));
			literatureList.add(createLiterature("2", "112", "The book of fishing", LibraryObjectTypes.THESIS.getValue(), "Water and Co.", "2012-06-12 0:0:0", authorsC, statusC));
			literatureList.add(createLiterature("3", "112", "The book of swords", LibraryObjectTypes.BOOK.getValue(), "Excalibur and Co.", "2013-07-12 0:0:0", authorsC, statusD));
			literatureList.add(createLiterature("4", "112", "The book of staves", LibraryObjectTypes.BOOK.getValue(), "Wanda and Co.", "2013-08-12 0:0:0", authorsB, statusE));
			literatureList.add(createLiterature("5", "112", "The book of claws", LibraryObjectTypes.MAGAZINE.getValue(), "Beasts and Co.", "2015-10-12 0:0:0", authorsA, statusF));
			literatureList.add(createLiterature("6", "112", "The book of computers", LibraryObjectTypes.THESIS.getValue(), "Computers and Co.", "2017-05-12 0:0:0", authorsB, statusG));
			literatureList.add(createLiterature("7", "111", "<script></script>", LibraryObjectTypes.BOOK.getValue(), "Felicia and Co.", "2011-01-12 0:0:0", authorsA, statusA));
			*/
		}
		return instance;
	}
	
	public Literature searchLiteratureById(Long long1){
		for(int i = 0; i < literatureList.size(); i++){
			if(getBook(i).getId() == long1){
				return getBook(i);
			}
		}
		return null;
	}

	public long addLiterature(Literature literature){
		long id = literatureList.size();
		literature.setId(id);
		if(literatureList.add(literature)){
			DBConnection con = new DBConnection();
			con.createLiteratureWithId((int) id,
										literature.getLibraryObjectType(),
										literature.getTitle(),
										DateUtil.getCurrentDate().toString(),
										literature.getPublisher(),
										0);
			return id;
		}
		return -1;
	}
	
	private static Literature createLiterature(String id, String dds, String title, int type, String publisher, String datePublished, NameList authors, Status status){
		Literature lit = createLiterature(dds, title, type, publisher, datePublished, authors, status);
		lit.setId(Long.valueOf(id));
		
		return lit;
	}
	
	public static Literature createLiterature(String dds, String title, int type, String publisher, String datePublished, NameList authors, Status status){
		Literature lit = new Literature();
		
		lit.setDds(dds);
		lit.setTitle(title);
		lit.setLibraryObjectType(type);
		lit.setPublisher(publisher);
		lit.setDatePublished(DateUtil.readDateFromString(datePublished));
		lit.setAuthors(authors);
		lit.setStatus(status);
		
		return lit;
	}
	
	public LiteratureList getAllLiterature(){
		for(int i = 0; i < literatureList.size(); i++){
			Literature literature = removeBook(i);
			literatureList.add(i, literature);
		}
		return literatureList;
	}
	
	public boolean reserve(Literature literature, User user){
		if(ReservationManager.reserve(literature, user)){
			user.addToLiteratureList(literature);
			return true;
		}
		return false;
	}
	
	public boolean borrow(Literature literature){
		literature.getStatus().setAvailability(Status.STATUS_OUT);
		return true;
	}
	
	public LiteratureList getAllInCategory(int category){
		LiteratureList searched = new LiteratureList();
		for(int i = 0; i < literatureList.size(); i++){
			if(getBook(i).getLibraryObjectType() == category){
				Literature literature = getBook(i);
				searched.add(literature);
			}
		}
		return searched;
	}
	
	public LiteratureList search(String searchString, int field){
		LiteratureList searched = new LiteratureList();
		if(field == Literature.FIELD_ALL){
			for(int i = 0; i < literatureList.size(); i++){
				Literature currLit = getBook(i);
				
				boolean isCriteriaMet = false;
				if(matches(currLit.getTitle(), searchString)){
					isCriteriaMet = true;
				}else if(matches(currLit.getPublisher(), searchString)){
					isCriteriaMet = true;
				}else{
					for(int j = 0; j < currLit.getAuthors().size(); j++){
						if(matches(currLit.getAuthors().get(j).getFirstName(), searchString) ||
								matches(currLit.getAuthors().get(j).getMiddleName(), searchString) ||
								matches(currLit.getAuthors().get(j).getLastName(), searchString)){
							isCriteriaMet = true;
							break;
						}
					}
				}
				if(isCriteriaMet){
					searched.add(currLit);
				}
			}
		}else{
			for(int i = 0; i < literatureList.size(); i++){
				Literature currLit = getBook(i);
				if(field == Literature.FIELD_TITLE){
					if(matches(currLit.getTitle(), searchString)){
						searched.add(currLit);
					}
				}else if(field == Literature.FIELD_AUTHOR){
					for(int j = 0; j < currLit.getAuthors().size(); j++){
						if(matches(currLit.getAuthors().get(j).getFirstName(), searchString) ||
								matches(currLit.getAuthors().get(j).getMiddleName(), searchString) ||
								matches(currLit.getAuthors().get(j).getLastName(), searchString)){
							searched.add(currLit);
						}
					}
				}else if(field == Literature.FIELD_PUBLISHER){
					if(matches(currLit.getPublisher(), searchString)){
						searched.add(currLit);
					}
				}
			}
		}
		return searched;
	}
	
	public LiteratureList search(String searchString, int field, int category){
		LiteratureList searched = new LiteratureList();
		if(field == Literature.FIELD_ALL){
			for(int i = 0; i < literatureList.size(); i++){
				Literature currLit = getBook(i);
				
				boolean isCriteriaMet = false;
				if(matches(currLit.getTitle(), searchString)){
					isCriteriaMet = true;
				}else if(matches(currLit.getPublisher(), searchString)){
					isCriteriaMet = true;
				}else{
					for(int j = 0; j < currLit.getAuthors().size(); j++){
						if(matches(currLit.getAuthors().get(j).getFirstName(), searchString) ||
								matches(currLit.getAuthors().get(j).getMiddleName(), searchString) ||
								matches(currLit.getAuthors().get(j).getLastName(), searchString)){
							isCriteriaMet = true;
							break;
						}
					}
				}
				if(isCriteriaMet){
					searched.add(currLit);
				}
			}
		}else{
			for(int i = 0; i < literatureList.size(); i++){
				Literature currLit = getBook(i);
				if(field == Literature.FIELD_TITLE){
					if(matches(currLit.getTitle(), searchString)){
						searched.add(currLit);
					}
				}else if(field == Literature.FIELD_AUTHOR){
					for(int j = 0; j < currLit.getAuthors().size(); j++){
						if(matches(currLit.getAuthors().get(j).getFirstName(), searchString) ||
								matches(currLit.getAuthors().get(j).getMiddleName(), searchString) ||
								matches(currLit.getAuthors().get(j).getLastName(), searchString)){
							searched.add(currLit);
						}
					}
				}else if(field == Literature.FIELD_PUBLISHER){
					if(matches(currLit.getPublisher(), searchString)){
						searched.add(currLit);
					}
				}
			}
		}
		return searched;
	}
	
	public boolean matches(String value, String searchQuery){
		return value.toLowerCase().contains(searchQuery.toLowerCase());
	}
	
	public boolean delete(long id){
		for(int i = 0; i < literatureList.size(); i++){
			if(getBook(i).getId() == id){
				literatureList.remove(i);
				return true;
			}
		}
		return false;
	}
	
	public void validateUserList(User user){
		for(int i = 0; i < user.getLiteratureList().size(); i++){
			long idToSearch = user.getLiteratureList().get(i).getId();
			Literature lit = searchLiteratureById(idToSearch);
			if(lit == null){
				user.getLiteratureList().remove(i);
			}else{
				if(lit.getStatus().getCurrentHolder().getId() != user.getId()){
					user.getLiteratureList().remove(i);
				}
			}
		}
	}
	
	public boolean updateLiteratureWithId(long id, Literature literature){
	    System.out.println(id);
		for(int i = 0; i < literatureList.size(); i++){
			System.out.println("CHECKING BOOT AT INDEX " + i + " WITH ID " + getBook(i).getId());
			if(getBook(i).getId() == id){
				sanitizeLiterature(literature);
				System.out.println("AFTER SANITIZATION: ");
				System.out.println(literature.getTitle());
                DBConnection con = new DBConnection();
                int dds;
                if(literature.getDds().isEmpty())
                    dds = 0;
                else
                    dds = Integer.parseInt(literature.getDds());
                con.updateLiterature((int) id,
                        literature.getLibraryObjectType(),
                        literature.getTitle(),
                        literature.getDatePublished().toString(),
                        literature.getPublisher(),
                        dds);
                for(int j = 0; j < literatureList.get(i).getAuthors().size(); j++){
                    con.deleteAuthorTag(literatureList.get(i).getAuthors().get(j).getId());
                    con.addAuthor(literature.getAuthors().get(j).getLastName(),
                                    literature.getAuthors().get(j).getFirstName(),
                                    literature.getAuthors().get(j).getMiddleName());
                    con.addTag((int) literature.getId(), con.getTagIDbyAuthor
                                                                (con.getAuthorIDWithLandF
                                                                        (literature.getAuthors().get(j).getLastName(),
                                                                        literature.getAuthors().get(j).getFirstName())));
                }
				literatureList.set(i, literature);
				return true;
			}
		}
		return false;
	}
	
	public void sanitizeLiterature(Literature literature){
		String dds = TextHandler.sanitize(literature.getDds());
		String title = TextHandler.sanitize(literature.getTitle());
		String publisher = TextHandler.sanitize(literature.getPublisher());
		NameList authors = new NameList();
		for(int i = 0; i < literature.getAuthors().size(); i++){
			authors.add(new Name(
				TextHandler.sanitize(literature.getAuthors().get(i).getFirstName()),					
				TextHandler.sanitize(literature.getAuthors().get(i).getMiddleName()),					
				TextHandler.sanitize(literature.getAuthors().get(i).getLastName())					
				));	
		}
		
		literature.setDds(dds);
		literature.setTitle(title);
		literature.setPublisher(publisher);
		literature.setAuthors(authors);
		
	}
	
	public Literature getBook(int index){
		Literature lit = literatureList.get(index);
		sanitizeLiterature(lit);
		return lit;
	}
	
	public Literature removeBook(int index){
		Literature lit = literatureList.remove(index);
		sanitizeLiterature(lit);
		return lit;
	}

	public Literature removeBookWithID(int id){
		for(int i = 0; i < literatureList.size(); i++){
			if(literatureList.get(i).getId() == id){
				Literature lit = literatureList.remove(i);
				DBConnection con = new DBConnection();
				con.deleteLiterature(id);
				con.deleteAuthorTag(id);
				sanitizeLiterature(lit);
				return lit;
			}
		}
		return null;
	}

    public long getLastKey(){
        long high = 0;
        for(int i = 0; i < literatureList.size(); i++){
            if(high < literatureList.get(i).getId()){
                high = literatureList.get(i).getId();
            }
        }
        return high + 1;
    }

}
