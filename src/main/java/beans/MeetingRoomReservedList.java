package beans;

import java.util.ArrayList;

public class MeetingRoomReservedList extends ArrayList<ArrayList<Status>>{
	public int getSize(int index){
		return this.get(index).size();
	}
}
