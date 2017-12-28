package com.personalWebsite.controller;

import com.alibaba.fastjson.JSON;
import com.personalWebsite.common.system.Constant;
import com.personalWebsite.entity.UserEntity;
import com.personalWebsite.service.UserService;
import com.personalWebsite.utils.MD5Util;
import com.qq.connect.api.OpenID;
import com.qq.connect.api.qzone.UserInfo;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.javabeans.qzone.UserInfoBean;
import com.qq.connect.oauth.Oauth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;

/**
 * Created by xiatianlong on 2017/12/24.
 */
@Controller
@RequestMapping("/login")
public class LoginController extends BaseController {

    @Autowired
    private UserService userService;

    /**
     * 调起qq登录时的浏览器地址，用户qq登录成功的重定向
     */
    private String qqRequestUrl = null;

    /**
     * 调起qq登录
     * @param request request
     * @param response response
     */
    @GetMapping("/qq")
    public void qqLogin(HttpServletRequest request, HttpServletResponse response) {
        try {
            // 获取请求的url并进行编码
            qqRequestUrl = request.getParameter("qqRequestUrl");
            qqRequestUrl = URLEncoder.encode(qqRequestUrl, "UTF-8");
            // 重定向到请求qq登录
            response.setContentType("text/html;charset=utf-8");
            response.sendRedirect(new Oauth().getAuthorizeURL(request));
        } catch (Exception e) {
            // TODO 这里对异常进行处理 去错误画面
            e.printStackTrace();

        }
    }

    /**
     * qq登录成功的回调
     * @param request request
     * @param response response
     */
    @GetMapping("/qq/callback")
    public void qqLoginCallBack(HttpServletRequest request, HttpServletResponse response) {

        try {
            AccessToken accessTokenObj = (new Oauth()).getAccessTokenByRequest(request);
            if (StringUtils.isEmpty(accessTokenObj.getAccessToken())) {
                // TODO 这里对异常进行处理 去错误画面
                System.out.print("没有获取到响应参数");
            } else {
                // 获取 accessToken
                String accessToken = accessTokenObj.getAccessToken();

                // 根据accessToken获取OpenId
                OpenID openIDObj = new OpenID(accessToken);
                String openID = openIDObj.getUserOpenID();

                // 根据accessToken 和 openId 获取用户信息
                UserInfo userInfo = new UserInfo(accessToken, openID);
                UserInfoBean userInfoBean = userInfo.getUserInfo();

                System.out.println("accessToken:" + accessToken);
                System.out.println("openID:" + openID);
                System.out.println("userInfoBean:" + userInfoBean);

                Date now = new Date();
                // 根据openid查询数据库是否存在此用户，存在即更新数据，不存在插入数据
                UserEntity userEntity = userService.findUserByOpenId(openID);
                if (userEntity == null){
                    userEntity = new UserEntity();
                    userEntity.setUserId(MD5Util.encryp(openID));
                    userEntity.setOpenId(openID);
                    userEntity.setCreateTime(now);
                    userEntity.setCreateUser(Constant.ADMIN);
                }
                userEntity.setAccessToken(accessToken);
                userEntity.setUserName(userInfoBean.getNickname());
                userEntity.setUserGender(userInfoBean.getGender());
                userEntity.setUserHeadImgSmall(userInfoBean.getAvatar().getAvatarURL50());
                userEntity.setUserHeadImgLarge(userInfoBean.getAvatar().getAvatarURL100());
                userEntity.setLastLoginTime(now);
                userEntity.setUpdateTime(now);
                userEntity.setUpdateUser(Constant.ADMIN);
                userService.saveAndFlush(userEntity);

                // 登录成功部分信息存入session
                com.personalWebsite.vo.UserInfo u = new com.personalWebsite.vo.UserInfo();
                u.setUserName(userEntity.getUserName());
                u.setUserId(userEntity.getUserId());
                u.setGender(userEntity.getUserGender());
                u.setEmail(userEntity.getUserEmail());
                if(!StringUtils.isEmpty(userEntity.getUserHeadImgLarge())){
                    u.setHeadImg(userEntity.getUserHeadImgLarge());
                }else{
                    u.setHeadImg(userEntity.getUserHeadImgSmall());
                }

                // 完成后将用户放入SESSION
                request.getSession().setAttribute("LOGIN_USER", u);
                request.getSession().setAttribute("LOGIN_USER_JSON", JSON.toJSON(u));

                // 重定向到登录时的画面
                response.sendRedirect(URLDecoder.decode(qqRequestUrl, "UTF-8"));
            }

        } catch (Exception e) {
            // TODO 对异常进行处理  去错误画面
            e.printStackTrace();
        }
    }


}
