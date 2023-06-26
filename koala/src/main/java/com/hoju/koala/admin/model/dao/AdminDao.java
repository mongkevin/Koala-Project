package com.hoju.koala.admin.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hoju.koala.admin.model.vo.AllCount;
import com.hoju.koala.admin.model.vo.BlockIp;
import com.hoju.koala.admin.model.vo.CreateSetting;
import com.hoju.koala.admin.model.vo.ErrorDivision;
import com.hoju.koala.admin.model.vo.IssuesAndError;
import com.hoju.koala.admin.model.vo.MemberSearch;
import com.hoju.koala.admin.model.vo.SqlCloud;
import com.hoju.koala.admin.model.vo.Supporters;
import com.hoju.koala.board.model.vo.ErrorBoard;
import com.hoju.koala.board.model.vo.ErrorSet;
import com.hoju.koala.common.model.vo.PageInfo;
import com.hoju.koala.member.model.vo.Member;


// rawtypes : 제네릭 타입이 불완전하다
@SuppressWarnings({ "unchecked", "rawtypes" })
@Repository
public class AdminDao {
	
	public AllCount selectAllCount(SqlSession sqlSession) {
		return sqlSession.selectOne("adminMapper.allCount");
	}

	public ArrayList<Supporters> selectSupporters(SqlSession sqlSession, PageInfo pi) {
		return (ArrayList) sqlSession.selectList("adminMapper.selectSupporters",null, pi.rowBounds());
	}
	
	public ArrayList<CreateSetting> selectCreateSetting(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectWaitingLibrary");
	}

	public ArrayList<IssuesAndError> selectErrorBoardCount(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectErrorBoardCount");
	}

	public ArrayList<BlockIp> selectBolckIp(SqlSession sqlSession, PageInfo pi) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectBolckIp",null, pi.rowBounds());
	}
	
	public ArrayList<Supporters> selectMemberList(SqlSession sqlSession, PageInfo pi) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectMemberList",null, pi.rowBounds());
	}

	public ArrayList<Supporters> selectMembercondition(MemberSearch ms, PageInfo pi, SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectMembercondition",ms, pi.rowBounds());
	}
	
	public ArrayList<IssuesAndError> selectIssues(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectIssues");
	}
	
	public BlockIp selectBlockIpUser(String ip, SqlSession sqlSession) {
		return sqlSession.selectOne("adminMapper.selectBlockIpUser", ip);
	}

	public int insertBlockIpUser(String ip, SqlSession sqlSession) {
		return sqlSession.insert("adminMapper.insertBlockIpUser", ip);
	}

	public int updateBlockIpUser(String ip, SqlSession sqlSession) {
		return sqlSession.update("adminMapper.updateBlockIpUser", ip);
	}

	public int blockBlockIpUser(String ip, SqlSession sqlSession) {
		return sqlSession.update("adminMapper.blockBlockIpUser", ip);
	}

	public int updateblockClear(String blackIp, SqlSession sqlSession) {
		return sqlSession.update("adminMapper.updateblockClear", blackIp);
	}
	
	public int updateblockAction(String blackIp, SqlSession sqlSession) {
		return sqlSession.update("adminMapper.updateblockAction", blackIp);
	}
	
	public int deleteSupporter(String userNo, SqlSession sqlSession) {
		return sqlSession.delete("adminMapper.deleteSupporter", userNo);
	}

	public int InsertSupporters(int client_No, SqlSession sqlSession) {
		return sqlSession.insert("adminMapper.InsertSupporters", client_No);
	}

	public int deleteSupporters(int client_No, SqlSession sqlSession) {
		return sqlSession.delete("adminMapper.deleteSupporters", client_No);
	}

	public Supporters selectOneSupport(int userNo, SqlSession sqlSession) {
		return sqlSession.selectOne("adminMapper.selectOneSupport", userNo);
	}

	public int selectCountMemberCondition(MemberSearch ms, SqlSession sqlSession) {
		return sqlSession.selectOne("adminMapper.selectCountMemberCondition", ms);
	}

	public ArrayList<Supporters> selectSupporterWaitList(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectSupporterWaitList");
	}

	public int insertSupporterGithubId(Supporters supporter, SqlSession sqlSession) {
		return sqlSession.update("adminMapper.insertSupporterGithubId", supporter);
	}

	public ErrorBoard selectIssueDetail(String settingTitle, SqlSession sqlSession) {
		return sqlSession.selectOne("adminMapper.selectIssueDetail", settingTitle);
	}

	public ArrayList<ErrorSet> selectErrorDetail(String settingTitle, SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectErrorDetail", settingTitle);
	}

	public int updateErrorType(ErrorDivision ed, SqlSession sqlSession) {
		return sqlSession.update("adminMapper.updateErrorType", ed);
	}

	public String selectSqlTitle(String string, SqlSession sqlSession) {
		return sqlSession.selectOne("adminMapper.selectSqlTitle", string);
	}

	public ArrayList<SqlCloud> selectTeam(int userNo, SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectTeam", userNo);
	}

	public ArrayList<Member> selectTeamMember(int teamNo, SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.selectTeamMember", teamNo);
	}

	public int selectCreator(int teamNo, SqlSession sqlSession) {
		return sqlSession.selectOne("adminMapper.selectCreator", teamNo);
	}
}
