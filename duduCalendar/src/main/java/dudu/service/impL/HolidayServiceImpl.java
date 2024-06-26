package dudu.service.impL;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

import dudu.HolidayVO;
import dudu.HolidayExplorer;
import dudu.dao.HolidayDAO;
import dudu.service.HolidayService;

@Service("HolidayService")
public class HolidayServiceImpl implements HolidayService {

	@Resource(name = "HolidayDAO")
	private HolidayDAO holidayDAO;

	@Override
	@Transactional
	public List<HolidayVO> getHolidayService() throws IOException {
		// 샘플코드를 활용해서 xml -> jsonObject로 변환
		List<HolidayVO> holidayList = new ArrayList<>();

		String solYear = String.valueOf(LocalDate.now().getYear());

		HolidayExplorer holidayExplorer = new HolidayExplorer();

		for (int solMonth = 1; solMonth <= 12; solMonth++) {
			// 숫자 2자리 맞춤
			String strMonth = String.valueOf(solMonth);
			while (strMonth.length() < 2) {
				strMonth = "0" + strMonth;
			}

			JSONObject jsonData = holidayExplorer.getHolidayExplorer(solYear, strMonth);
			JSONObject body = jsonData.getJSONObject("response").getJSONObject("body");

			if (body.getInt("totalCount") != 0) {
				// 공휴일 값이 하나일 때는 item이 jsonObject로 받아지기 때문에 조건문 사용
				if (body.getInt("totalCount") == 1) {
					JSONObject item = body.getJSONObject("items").getJSONObject("item");
					if (item.getString("isHoliday").equals("Y")) { // 공휴일이 맞을 경우
						String holidayDate = String.valueOf(item.getInt("locdate"));
						
						Map<String, String> param = new HashMap<String, String>();
						param.put("holidayDate", holidayDate);
						param.put("holidayName", item.getString("dateName"));
						
						//중복방지
						if(holidayDAO.selectOne("HolidayDAO.existsByHolidayDate", param)==null) {
							String holidayName = item.getString("dateName");
							HolidayVO holidayVO = new HolidayVO();
							holidayVO.setHolidayStart(holidayDate);
							holidayVO.setHolidayEnd(holidayDate);
							holidayVO.setHolidayName(holidayName);
							holidayList.add(holidayVO);
						}
					}
				} else {
					JSONArray items = body.getJSONObject("items").getJSONArray("item");

					for (int i = 0; i < items.length(); i++) {
						Object item = items.get(i);
						JSONObject map = new JSONObject(new Gson().toJson(item)).getJSONObject("map");
						System.out.println("map: " + map);
						if (map.getString("isHoliday").equals("Y")) { // 공휴일이 맞을 경우
							HolidayVO holidayVO = new HolidayVO();
							String holidayDate = String.valueOf(map.getInt("locdate"));
							
							Map<String, String> param = new HashMap<String, String>();
							param.put("holidayDate", holidayDate);
							param.put("holidayName", map.getString("dateName"));
							
							//중복방지
							if(holidayDAO.selectOne("HolidayDAO.existsByHolidayDate", param)==null) {
								String holidayName = map.getString("dateName");
								holidayVO.setHolidayStart(holidayDate);
								holidayVO.setHolidayEnd(holidayDate);
								holidayVO.setHolidayName(holidayName);
								holidayList.add(holidayVO);
							}
							
						}
					}

				}
			}
			
			if (solYear.equals(String.valueOf(LocalDate.now().getYear())) && solMonth == 12) {
                // 내년까지 저장
                solYear = String.valueOf(LocalDate.now().plusYears(1).getYear());
                solMonth = 1;
            }
		}
		
		if (!holidayList.isEmpty()) {
            holidayDAO.insert("HolidayDAO.saveAll", holidayList);
            return holidayList;
        } else {
            return holidayList;
        }

	}
	@Override
	public List<HolidayVO> getHoliday() {
		return holidayDAO.selectList("HolidayDAO.getHolidayList");
	}

}
