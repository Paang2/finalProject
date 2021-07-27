package com.last.prj.emp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.last.prj.emp.EmpVO;
import com.last.prj.emp.mapper.EmpMapper;
import com.last.prj.emp.service.EmpService;


@Service
public class EmpServiceImpl implements EmpService {

	@Autowired EmpMapper empDAO;
	
	@Override
	public EmpVO getEmp(EmpVO empVO) {
		return empDAO.getEmp(empVO);
	}

	@Override
	public List<EmpVO> getEmpList(EmpVO empVO) {
		return empDAO.getEmpList();
	}

	@Override
	public void empInsert(EmpVO empVO) {
		//empDAO.insertEmp(empVO);
	}

}
