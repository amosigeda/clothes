package com.care.sys.appuserinfo.dao;

import java.util.Collection;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.care.sys.appuserinfo.domain.AppUserInfo;
import com.godoing.rose.lang.DataMap;

public interface AppUserInfoDao {
	
	public List<DataMap> getAppUserInfo(AppUserInfo vo) throws DataAccessException;
	
	public Integer insertAppUserInfo(AppUserInfo vo) throws DataAccessException;
	
	public Integer updateAppUserInfo(AppUserInfo vo) throws DataAccessException;

	public Integer getAppUserInfoCount(AppUserInfo vo) throws DataAccessException;
	
	public List<DataMap> getAppUserInfoListByVo(AppUserInfo vo) throws DataAccessException;
	
	public List<DataMap> getAppUserInfoGroupByTime(AppUserInfo vo) throws DataAccessException;
	
	public Integer getAppUserInfoCountGroupByTime(AppUserInfo vo) throws DataAccessException;
	
	public Integer getAppUserInfoCountByVo(AppUserInfo vo) throws DataAccessException;

	public int insertUserPhotoInfo(AppUserInfo vo)throws DataAccessException;

	public List<DataMap> getUserPhotoInfo(AppUserInfo vo)throws DataAccessException;

	public List<DataMap> getProjectImageInfo(AppUserInfo ao)throws DataAccessException;

	public Integer insertSaoMaInfo(AppUserInfo vo)throws DataAccessException;

	public List<DataMap> getSaoMaInfoListByVo(AppUserInfo vo)throws DataAccessException;

	public Integer getSaoMaInfoCount(AppUserInfo vo)throws DataAccessException;

}
