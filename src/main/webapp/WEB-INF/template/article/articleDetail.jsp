<%@ page import="com.personalWebsite.common.enums.ArticleStatus" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="DRAFT" value="<%=ArticleStatus.DRAFT.getCode()%>" scope="request"/>
<c:set var="UNDER_REVIEW" value="<%=ArticleStatus.UNDER_REVIEW.getCode()%>" scope="request"/>
<c:set var="REVIEW_PASSED" value="<%=ArticleStatus.REVIEW_PASSED.getCode()%>" scope="request"/>
<c:set var="REVIEW_NOT_PASSED" value="<%=ArticleStatus.REVIEW_NOT_PASSED.getCode()%>" scope="request"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../base/head.jsp"/>
    <title>${article.articleTitle}</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/plugins/wangEditor_v3.1.0/wangEditor.min.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/xtl-content.css">
</head>
<body>

<!--header begin-->
<jsp:include page="../base/header.jsp"/>
<!--header end-->
<div class="layui-container">
    <span class="layui-breadcrumb">
        <a href="${pageContext.request.contextPath}/home"><i class="layui-icon">&#xe68e;</i></a>
        <a href="${pageContext.request.contextPath}/article">文章</a>
        <a><cite>文章详情</cite></a>
    </span>
</div>


<div class="layui-container">


    <!--上部部分begin-->
    <div class="layui-row">
        <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 xtl-block padding-t-20 padding-b-20 xtl-content">
            <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 title">
                ${article.articleTitle}
            </div>
            <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 category">
                <c:forEach items="${article.categoryList}" var="category">
                    <span class="layui-badge-rim red margin-r-10">${category}</span>
                </c:forEach>
            </div>
            <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 content w-e-text">
                ${article.articleContent}
            </div>
            <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 footer">
                <a class="create-user" href="${pageContext.request.contextPath}/user/${article.userId}"
                   target="_blank">${article.userName}</a><br>
                ${article.fmtCreateTime}
            </div>
            <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 text-c font-size-14" id="collectionContent">
                <c:choose>
                    <c:when test="${not empty isCollection && isCollection}">
                        <i class="fa fa-star collectionBtn" aria-hidden="true"></i>
                    </c:when>
                    <c:otherwise>
                        <i class="fa fa-star-o collectionBtn" aria-hidden="true" id="collectionBtn"></i>
                    </c:otherwise>
                </c:choose>
                <div>收藏</div>
            </div>
            <input type="hidden" id="articleId" value="${article.articleId}">
        </div>
    </div>
    <!--上部部分end-->

    <!--评论部分begin-->
    <div class="layui-row">
        <c:set value="${article.articleId}" var="commentBizId" scope="request"/>
        <c:set value="004001" var="commentBizType" scope="request"/>
        <c:set value="${dataList}" var="messageDataList" scope="request"/>
        <c:set value="${totalCnt}" var="messageTotalCnt" scope="request"/>
        <c:set value="${pageNo}" var="messagePageNo" scope="request"/>
        <c:set value="${pageSize}" var="messagePageSize" scope="request"/>
        <jsp:include page="../base/message.jsp"/>
    </div>
    <!--评论部分end-->

</div>

<jsp:include page="../base/footer.jsp"/>
<script src="${pageContext.request.contextPath}/resources/js/biz/article/articleDetail.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/biz/message.js"></script>
</body>
</html>