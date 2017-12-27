<%--
  Created by IntelliJ IDEA.
  User: xiati
  Date: 2017/12/7
  Time: 10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="layui-col-xs12 layui-col-sm12 layui-col-md12 xtl-block padding-l-15 padding-r-15">
    <div class="layui-col-xs12 layui-col-sm12 layui-col-md12">
        <fieldset class="layui-elem-field layui-field-title">
            <c:choose>
                <c:when test="${not empty LOGIN_USER}">
                    <legend class="font-size-16"><a href="" class="green">${LOGIN_USER.userName}</a>，留下您的脚印！</legend>
                </c:when>
                <c:otherwise>
                    <legend class="font-size-16">请点击右上方的QQ图标登录，登录后即可留言！</legend>
                </c:otherwise>
            </c:choose>
        </fieldset>
    </div>
    <div class="layui-col-xs12 layui-col-sm12 layui-col-md12">
        <%--富文本区域 begin--%>
        <div id="xtl-message-editor"></div>
        <%--富文本区域 end--%>
            <a class="layui-btn layui-btn-normal layui-btn-sm margin-t-15 margin-b-15 float-r <c:if test="${empty LOGIN_USER}">layui-btn-disabled</c:if> "
           id="xtl-message-submit-btn"><i class="layui-icon">&#xe609;</i> 提交留言</a>

    </div>
    <hr class="layui-bg-green">
    <div class="layui-col-xs12 layui-col-sm12 layui-col-md12">
        <!--评论部分 begin-->
        <div class="layui-col-xs12 layui-col-sm12 layui-col-md12" id="xtl-comment-content">
            <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 xtl-comment level1">
                <div class="xtl-comment-user-img"><img
                        src="${pageContext.request.contextPath}/resources/images/icon/website_logo_64px.png">
                </div>
                <div class="xtl-comment-user-info">
                    <div class="xtl-comment-user-name">夏天龙</div>
                    <div class="xtl-comment-content">我是评论内容</div>
                    <div class="xtl-comment-time">
                        <span class="gray"><i class="fa fa-clock-o" aria-hidden="true"></i> 1小时前</span>
                        <span class="blue xtl-comment-reply"><i class="fa fa-commenting" aria-hidden="true"></i> 回复</span>
                    </div>

                    <div class="level2-common-content">
                        <%--二级回复 begin--%>
                        <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 xtl-comment level2">
                            <div class="xtl-comment-user-img"><img
                                    src="${pageContext.request.contextPath}/resources/images/icon/website_logo_64px.png">
                            </div>
                            <div class="xtl-comment-user-info">
                                <div class="xtl-comment-user-name">李三</div>
                                回复
                                <div class="xtl-comment-user-name">夏天龙</div>
                                <div class="xtl-comment-content">我是评论内容</div>
                                <div class="xtl-comment-time">
                                    <span class="gray"><i class="fa fa-clock-o" aria-hidden="true"></i> 1小时前</span>
                                    <span class="blue xtl-comment-reply"><i class="fa fa-commenting"
                                                                            aria-hidden="true"></i> 回复</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--二级回复 end--%>

                    <%--回复评论框容器 begin--%>
                    <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 xtl-comment-reply-content"></div>
                    <%--回复评论框容器 end--%>

                </div>


            </div>

            <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 xtl-comment level1">
                <div class="xtl-comment-user-img"><img
                        src="${pageContext.request.contextPath}/resources/images/icon/website_logo_64px.png">
                </div>
                <div class="xtl-comment-user-info">
                    <div class="xtl-comment-user-name">夏天龙</div>
                    <div class="xtl-comment-content">我是评论内容</div>
                    <div class="xtl-comment-time">
                        <span class="gray"><i class="fa fa-clock-o" aria-hidden="true"></i> 1小时前</span>
                        <span class="blue xtl-comment-reply"><i class="fa fa-commenting" aria-hidden="true"></i> 回复</span>
                    </div>

                    <div class="level2-common-content"></div>

                    <%--回复评论框容器 begin--%>
                    <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 xtl-comment-reply-content"></div>
                    <%--回复评论框容器 end--%>
                </div>
            </div>


            <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 xtl-comment level1">
                <div class="xtl-comment-user-img"><img
                        src="${pageContext.request.contextPath}/resources/images/icon/website_logo_64px.png">
                </div>
                <div class="xtl-comment-user-info">
                    <div class="xtl-comment-user-name">夏天龙</div>
                    <div class="xtl-comment-content">我是评论内容</div>
                    <div class="xtl-comment-time">
                        <span class="gray"><i class="fa fa-clock-o" aria-hidden="true"></i> 1小时前</span>
                        <span class="blue xtl-comment-reply"><i class="fa fa-commenting" aria-hidden="true"></i> 回复</span>
                    </div>

                    <div class="level2-common-content"></div>

                    <%--回复评论框容器 begin--%>
                    <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 xtl-comment-reply-content"></div>
                    <%--回复评论框容器 end--%>
                </div>
            </div>

        </div>
        <!--评论部分 end-->
    </div>
</div>