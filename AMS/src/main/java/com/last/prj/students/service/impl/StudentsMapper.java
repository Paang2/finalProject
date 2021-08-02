package com.last.prj.students.service.impl;

import java.util.List;

import com.last.prj.professor.service.ProfessorVO;
import com.last.prj.students.service.StudentsVO;

public interface StudentsMapper {

	StudentsVO studentInfo(StudentsVO vo);			// 학적 조회
	List<StudentsVO> scoreView(StudentsVO vo);		// 성적 조회
	List<StudentsVO> appliedLecture(StudentsVO vo);	// 신청한 강의 조회
	List<StudentsVO> lectureLookUp(StudentsVO vo);	// 강의 시간표들 조회
	
	ProfessorVO professorSelect(ProfessorVO vo);	// 교수 정보 조회
	
	int studentUpdate(StudentsVO vo);				// 학적 수정
}