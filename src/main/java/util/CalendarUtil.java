package util;import java.util.List;

import dao.CalendarDao;
import dto.CalendarDto;

public class CalendarUtil {

	// 문자열 검사: 빈 문자열일 때 true 리턴, 빈 문자열이 아니면 false 리턴
	public static boolean nvl(String msg) {
		return msg == null || msg.trim().equals("") ? true : false;
	}

	// 한자리 숫자를 두자리로 만들어 주는 함수: 1 ~ 9 -> 01 ~ 09
	public static String two(String msg) {
		return msg.trim().length() < 2 ? "0" + msg.trim() : msg.trim();
	}

	// 일별(날짜별) 일정을 모두 볼 수 있는 callist.jsp로 이동
	public static String callist(int year, int month, int day) {
		String str = "";

		str += String.format("&nbsp;<a href='callist.jsp?year=%d&month=%d&day=%d'>", year, month, day);
		str += String.format("%2d", day);
		str += "</a>";
		
		return str;
	}

	// 일정추가 함수
	public static String calwrite(int year, int month, int day) {
		
		String str = "";
		String image = "<img src='images/pen2.png' width='18px' height='18px'>";
		
		str = String.format("<a href='calwrite.jsp?year=%d&month=%d&day=%d'>%s</a>", 
													year, month, day, image);
		return str;
	}
	
	// 문장이 길 경우 단락으로 처리하는 함수
	// cgv에서 친구와 영화보고 데이트 -> cgv에서 친구와... 로 바꾼다.
	public static String dot3(String msg) {
		String str = "";
		if(msg.length() >= 6) {
			str = msg.substring(0, 6);
			str += "...";
		}
		else {
			str = msg.trim();
		}
		return str;
	}
	
	// 날짜별로 테이블을 생성하기 위한 함수(+ 캘린더에 일정 제목들이 적히게 된다)
	public static String makeTable(int year, int month, int day, List<CalendarDto> list) {
		String str = "";
		
		// 2023 2 16 -> 20230216
		String dates = (year + "") + two(month + "") + two(day + "");
		
		str += "<table>";

		//rdate = 20230216110530 -> 20230216
		for (CalendarDto dto : list) {
			if(dto.getRdate().substring(0, 8).equals(dates)) {
				str += "<tr>";
				
				str += "	<td style='padding:0px;height:20'>";
				
				str += "		<a href='caldetail.jsp?seq=" + dto.getSeq()	+ "'>";
				
				str += "			<font style='font-size:10px'>";
				
				str += 					dot3(dto.getTitle());
				
				str += "			</font>";
				
				str += "		</a>";	
				
				str += "	</td>";
				
				str += "</tr>";
			}
				
		}
		
		str += "</table>";
		
		return str;
		
	}
	
	
	
}
