<%--
  Created by IntelliJ IDEA.
  User: xiati
  Date: 2017/12/7
  Time: 10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
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
            <c:choose>
                <c:when test="${not empty messageDataList}">
                    <c:forEach var="message" items="${messageDataList}">
                        <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 xtl-comment">
                            <div class="xtl-comment-user-img"><img src="${message.commentUserHeadImg}"></div>
                            <div class="xtl-comment-user-info">
                                <div class="xtl-comment-user-name">
                                    <a class="create-user"
                                       href="${pageContext.request.contextPath}/user/${message.commentUserId}"
                                       target="_blank">${message.commentUserName}</a>
                                </div>
                                <div class="xtl-comment-content">${message.commentContent}</div>
                                <div class="xtl-comment-time">
                                    <span class="gray">
                                        <i class="fa fa-clock-o" aria-hidden="true"></i> ${message.commentFmtTime}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <span id="xtl-comment-blank-content">暂无评论</span>
                </c:otherwise>
            </c:choose>
        </div>
        <!--评论部分 end-->

        <%--分页begin--%>
        <div class="layui-col-xs12 layui-col-sm12 layui-col-md12">
            <input type="hidden" id="pageSize" value="${messagePageSize}">
            <input type="hidden" id="dataCount" value="${messageTotalCnt}">
            <input type="hidden" id="commentBizType" value="${commentBizType}">
            <input type="hidden" id="commentBizId" value="${commentBizId}">
            <div id="messagePageContent"></div>
        </div>
        <%--分页end--%>

    </div>
</div>