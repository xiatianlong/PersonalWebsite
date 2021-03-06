package com.personalWebsite.dao;

import com.personalWebsite.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * 用户 Repository
 * Created by xiatianlong on 2017/12/27.
 */
public interface UserRepository extends JpaRepository<UserEntity, String> {

    /**
     * 根据openId查询User对象
     * @param openId    openId
     * @return User
     */
    UserEntity findByOpenId(String openId);

    /**
     * 根据UserID查询User对象
     *
     * @param userId  userId
     * @param deleted 是否删除
     * @return User
     */
    UserEntity findByUserIdAndDeleted(String userId, boolean deleted);

    /**
     * 查询最后一个用户
     *
     * @return User
     */
    @Query(value = "SELECT * FROM t_user u ORDER BY u.USER_ID DESC LIMIT 1", nativeQuery = true)
    UserEntity findLastUser();

    /**
     * 获取用户列表
     *
     * @return list
     */
    @Query(value = "SELECT * FROM t_user u WHERE u.IS_DELETE = 0 ORDER BY u.CREATE_TIME DESC ", nativeQuery = true)
    List<UserEntity> getUserList();
}
