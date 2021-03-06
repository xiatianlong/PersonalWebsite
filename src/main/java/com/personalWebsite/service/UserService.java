package com.personalWebsite.service;

import com.personalWebsite.entity.UserEntity;
import com.personalWebsite.model.request.member.SettingForm;
import com.personalWebsite.model.response.user.UserDetail;

import java.util.List;

/**
 * User Service.
 * Created by xiatianlong on 2017/12/27.
 */
public interface UserService extends BaseService {


    /**
     * 保存用户对象
     * @param userEntity user
     */
    void saveAndFlush(UserEntity userEntity);

    /**
     * 根据OpenId获取用户
     * @param openId openId
     * @return  user
     */
    UserEntity findUserByOpenId(String openId);

    /**
     * 根据userId获取用户
     *
     * @param userId userId
     * @return user
     */
    UserEntity findUserByUserId(String userId);

    /**
     * 获取用户详情
     *
     * @param userId 用户id
     * @return 用户详情
     * @throws Exception e
     */
    UserDetail getUserDetail(String userId) throws Exception;

    /**
     * 获取最后一个用户
     *
     * @return user
     */
    UserEntity findLastUser();

    /**
     * 个人中心信息设置
     *
     * @param form 设置表单
     */
    void settingUserInfo(SettingForm form);

    /**
     * 获取用户列表
     *
     * @return list
     */
    List<UserEntity> getUserList();

}
