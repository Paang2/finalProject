package com.last.prj.students.web;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.last.prj.professor.service.ProfessorService;
import com.last.prj.professor.service.ProfessorVO;
import com.last.prj.students.service.StudentsService;
import com.last.prj.students.service.StudentsVO;


@Controller
public class StudentsController {

	@Autowired
	private StudentsService stService;
	
	@Autowired
	private ProfessorService pfService;

	////////////////////////////////////////////////////////////

	@RequestMapping("/studentInfo")
	public String studentInfo(StudentsVO svo, Model model, HttpSession session, ProfessorVO pvo) {
		// 학생 정보 조회 페이지로 이동 및 한 학생 정보 조회

		svo.setSid((String) session.getAttribute("id"));
		
		// 학생정보
		model.addAttribute("st", stService.studentInfo(svo));
		
		pvo.setPid(stService.studentInfo(svo).getPid());
		// 지도교수 정보
		model.addAttribute("pro", pfService.professorSelect(pvo));
		
//		// list 갯수
//		List<StudentsVO> list = stService.scoreView(vo);
//		model.addAttribute("count", list.size());
//		
//		// 시험점수
//		model.addAttribute("score", stService.scoreView(vo));
		
		return "students/studentInfo.tiles";
	}
	
	// grid api 값 받아오기
	@RequestMapping("scoreGetList")
	@ResponseBody
	public Map<String, Object> scoreGetList(HttpSession session, @RequestBody Map<String, String> map, StudentsVO vo) {
		vo.setSid((String) session.getAttribute("id"));
		
		if (map.get("year") != null) {
			vo.setLyear((String)map.get("year"));
			vo.setTerm(Integer.parseInt(map.get("term")));
		}
		
		// 시험점수 리스트 보내주기
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> datas = new HashMap<String, Object>();
		data.put("result", true);
		datas.put("contents", stService.scoreView(vo));
		data.put("data", datas);
		
		return data;
	}
	
	@RequestMapping("/infoConfirmPage")
	public String infoConfirm() {
		// 본인확인 페이지로 이동하기

		return "students/infoConfirm";
	}

	
	@RequestMapping("/infoConfirm")
	public String confirmingInfo(StudentsVO vo, Model model, HttpSession session) {
		// 본인 확인 과정 > 학생 정보(비밀번호) 수정 페이지로 이동

		String path = null;
		String realID = (String) session.getAttribute("id");
		StudentsVO result = stService.selfAuthentication(vo);
		
		if (result == null || !realID.equals(vo.getSid())) {
			// 조회 결과가 없거나, 세션 아이디와 받은 아이디 값이 다를 경우

			path = "students/infoConfirm";
		} else {
			// 정보 일치할 경우

			// model.addAttribute("st", result);
			path = "students/infoModify.tiles";
		}

		return path;
	}
	
	
	@RequestMapping("/scoreView")
	public String scoreView(StudentsVO vo, Model model, HttpSession session) {
		// 성적 조회 페이지

		vo.setSid((String) session.getAttribute("id"));
		model.addAttribute("st", stService.scoreView(vo));

		return "students/studentScoreView.tiles";
	}
	
	@RequestMapping("/appliedLecture")
	public String appliedLecture(StudentsVO vo, Model model, HttpSession session){
		// 수강 신청한(했던) 과목 조회

		// select
		vo.setLyear("2021");
		vo.setTerm(1);
		
		// session
		vo.setSid((String) session.getAttribute("id"));
		
		model.addAttribute("st", stService.appliedLecture(vo));

		return "students/appliedLecture.tiles";
	}

	
	@RequestMapping("/lectureLookUp")
	public String lectureLookUp(StudentsVO vo, Model model) {
		// 강의 시간표들 조회 (수강 신청 과정)

		// common code
		//vo.setLyear("2021");
		vo.setTerm(1);

//		String divi = vo.getDivision();
//		List<StudentsVO> diviResult = new ArrayList<StudentsVO>();
//		
//		if (divi.equals("교양")) {
//			
//			vo.setDcode("001");
//			diviResult = stService.lectureLookUp(vo);
//			
//			vo.setDcode("002");
//			stService.lectureLookUp(vo);
//		}
		
		System.out.println("\n조회 결과 : " + stService.lectureLookUp(vo) + "\n");
		
		model.addAttribute("lec", stService.lectureLookUp(vo));

		return "students/lectureLookUp.tiles";
	}
	
	// 모달에서 클릭 이벤트 발생시킬 때 사용하려고 했는데 이벤트 발생 페이지에서 교수 정보 다 불러 오면 굳이 필요 없음
//	@RequestMapping("/professorSelect")
//	public String professorSelect(ProfessorVO vo, Model model) {
//		// 교수 정보 보기
//		
//		model.addAttribute("prf", stService.professorSelect(vo));
//		
//		return "students/appliedLecture";
//	}
	
	@RequestMapping("/studentUpdate")
	public String studentUpdate(StudentsVO vo, Model model, HttpSession session) {
		// 학생 정보 수정
		
		String path = null;
		vo.setSid((String) session.getAttribute("id"));
		int result = stService.studentUpdate(vo);
		
		if (result != 0) {

			System.out.println("비밀번호 변경됨.");
			
			stService.studentUpdate(vo);
			
			model.addAttribute("st", stService.studentInfo(vo));
			path = "students/studentInfo.tiles";			
		} else {

			System.out.println("비밀번호 변경 안 됨.");
			
			path = "students/infoModify.tiles";
		}

		return path;
	}

	
	// ajax 시험성적 검색기능
//	@PostMapping("")
}
