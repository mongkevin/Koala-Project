package com.hoju.koala.setting.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.hoju.koala.setting.model.vo.Setting;

@Repository
public class SettingDao {

	//리스트 조회
	public ArrayList<Setting> selectList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("settingMapper.selectList");
	}
	

}