package com.care.sys.appuserinfo.domain.logic;

import java.util.List;

import com.care.sys.appuserinfo.domain.AppUserInfo;
import com.godoing.rose.lang.DataList;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;

public interface AppUserInfoFacade {

	public List<DataMap> getAppUserInfo(AppUserInfo vo) throws SystemException;

	public Integer insertAppUserInfo(AppUserInfo vo) throws SystemException;

	public Integer updateAppUserInfo(AppUserInfo vo) throws SystemException;

	public Integer getAppUserInfoCount(AppUserInfo vo) throws SystemException;
	
	public DataList getAppUserInfoListByVo(AppUserInfo vo) throws SystemException;
	
	public DataList getAppUserInfoGroupByTime(AppUserInfo vo) throws SystemException;
	
	public Integer getAppUserInfoCountGroupByTime(AppUserInfo vo) throws SystemException;
	
	public Integer getAppUserInfoCountByVo(AppUserInfo vo) throws SystemException;

	public int insertUserPhotoInfo(AppUserInfo vo)throws SystemException;

	public List<DataMap> getUserPhotoInfo(AppUserInfo vo)throws SystemException;

	public List<DataMap> getProjectImageInfo(AppUserInfo ao)throws SystemException;

	public Integer insertSaoMaInfo(AppUserInfo vo)throws SystemException;

	public DataList getSaoMaInfoListByVo(AppUserInfo vo)throws SystemException;

	public List<DataMap> getSaoMaInfo(AppUserInfo vo)throws SystemException;

	public int deleteById(AppUserInfo vo)throws SystemException;

	public int insertSaoMaInfoNew(AppUserInfo vo)throws SystemException;

	public List<DataMap> getSaoMaInfoNew(AppUserInfo vo)throws SystemException;

	public int updateSaoMaInfo(AppUserInfo voNumber)throws SystemException;
}
