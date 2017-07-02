package manager;

import beans.LibraryObjectTypes;
import beans.Literature;
import beans.LiteratureList;
import beans.Name;
import beans.Status;
import beans.list.NameList;
import util.DateUtil;

public class LiteratureManager {
	private static volatile LiteratureManager instance;

	private static LiteratureList literatureList;
	
	private LiteratureManager(){
		
	}
	
	public static LiteratureManager getInstance(){
		if(instance == null){
			instance = new LiteratureManager();
			
			literatureList = new LiteratureList();
			
			Name authorA = new Name("Mahou", "Papua", "Eksdi");
			Name authorB = new Name("Will", "Thea", "Powers");
			Name authorC = new Name("Fee", "Fokin", "Shing");

			NameList authors = new NameList();
			authors.add(authorA);
			authors.add(authorB);
			authors.add(authorC);

			Status statusA = new Status();
			Status statusB = new Status();
			Status statusC = new Status();
			Status statusD = new Status();
			Status statusE = new Status();
			Status statusF = new Status();
			Status statusG = new Status();
			
			
			literatureList.add(createLiterature("1", "111", "The book of magic", String.valueOf(LibraryObjectTypes.BOOK), "Felicia and Co.", "2011-01-12 0:0:0", authors, statusA));
			literatureList.add(createLiterature("2", "112", "The book of power", String.valueOf(LibraryObjectTypes.BOOK), "Felicia and Co.", "2012-05-12 0:0:0", authors, statusB));
			literatureList.add(createLiterature("3", "112", "The book of fishing", String.valueOf(LibraryObjectTypes.BOOK), "Felicia and Co.", "2012-06-12 0:0:0", authors, statusC));
			literatureList.add(createLiterature("4", "112", "The book of swords", String.valueOf(LibraryObjectTypes.BOOK), "Felicia and Co.", "2013-07-12 0:0:0", authors, statusD));
			literatureList.add(createLiterature("5", "112", "The book of staves", String.valueOf(LibraryObjectTypes.BOOK), "Felicia and Co.", "2013-08-12 0:0:0", authors, statusE));
			literatureList.add(createLiterature("6", "112", "The book of claws", String.valueOf(LibraryObjectTypes.BOOK), "Felicia and Co.", "2015-10-12 0:0:0", authors, statusF));
			literatureList.add(createLiterature("7", "112", "The book of computers", String.valueOf(LibraryObjectTypes.BOOK), "Felicia and Co.", "2017-05-12 0:0:0", authors, statusG));
		}
		return instance;
	}
	
	public Literature searchLiteratureById(Long long1){
		for(int i = 0; i < literatureList.size(); i++){
			if(literatureList.get(i).getId() == long1){
				return literatureList.get(i);
			}
		}
		return null;
	}

	private static Literature createLiterature(String id, String dds, String title, String type, String publisher, String datePublished, NameList authors, Status status){
		Literature lit = createLiterature(dds, title, type, publisher, datePublished, authors, status);
		lit.setId(Long.valueOf(id));
		
		return lit;
	}
	
	public static Literature createLiterature(String dds, String title, String type, String publisher, String datePublished, NameList authors, Status status){
		Literature lit = new Literature();;
		
		lit.setDds(dds);
		lit.setTitle(title);
		lit.setType(type);
		lit.setPublisher(publisher);
		lit.setDatePublished(DateUtil.readDateFromString(datePublished));
		lit.setAuthors(authors);
		lit.setStatus(status);
		
		return lit;
	}
	
	public static LiteratureList getAllLiterature(){
		return literatureList;
	}
}
