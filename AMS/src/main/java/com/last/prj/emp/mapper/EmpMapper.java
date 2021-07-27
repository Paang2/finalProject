package com.last.prj.emp.mapper;

import java.util.List;
import java.util.Map;

import com.last.prj.emp.EmpVO;

public interface EmpMapper {

	public EmpVO getEmp(EmpVO empVO);
	public List<EmpVO> getEmpList();
	public void empInsert(EmpVO empVO);
	public String getName(Integer id);
	public List<Map<String, Object>> getEmpMap();
	public List<Map<String, Object>> getDeptEmpCnt();
}

