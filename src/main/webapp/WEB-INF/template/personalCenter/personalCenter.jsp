<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../base/head.jsp"/>
    <title>个人中心</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/biz/personalCenter/personalCenter.css">
</head>
<body>

<!--header begin-->
<jsp:include page="../base/header.jsp"/>
<!--header end-->
<div class="layui-container">
    <span class="layui-breadcrumb">
      <a href="${pageContext.request.contextPath}/home"><i class="layui-icon">&#xe68e;</i></a>
      <a><cite>个人中心</cite></a>
    </span>
</div>


<div class="layui-container">


    <!--上部部分begin-->
    <div class="layui-row">
        <div class="layui-col-xs12 layui-col-sm12 layui-col-md12 xtl-block text-c padding-t-30 padding-b-30">
            <div id="personalCenterHeadImg"><img src="${LOGIN_USER.headImg}"></div>
            <div class="margin-t-10 font-size-22">${LOGIN_USER.userName}</div>
            <div class="margin-t-5 gray font-size-14">${LOGIN_USER.createTime} 加入</div>
        </div>
    </div>
    <!--上部部分end-->

    <div class="layui-row layui-col-space20">
        <div class="layui-col-xs4 layui-col-sm3 layui-col-md3 horizontal-vertical-middle personal-center-item">
            <a href="${pageContext.request.contextPath}/member/publish">
                <div><i class="layui-icon layui-anim"  data-anim="layui-anim-rotate">&#xe608;</i></div>
                <div>发布</div>
            </a>
        </div>
        <div class="layui-col-xs4 layui-col-sm3 layui-col-md3 horizontal-vertical-middle personal-center-item">
            <a href="${pageContext.request.contextPath}/member/personalCenter/setting">
                <div><i class="layui-icon">&#xe620;</i></div>
                <div>设置</div>
            </a>
        </div>
        <div class="layui-col-xs4 layui-col-sm3 layui-col-md3 horizontal-vertical-middle personal-center-item">
            <a href="${pageContext.request.contextPath}/member/article/list">
                <div><i class="layui-icon">&#xe705;</i></div>
                <div>我的文章</div>
            </a>
        </div>
        <div class="layui-col-xs4 layui-col-sm3 layui-col-md3 horizontal-vertical-middle personal-center-item">
            <a href="${pageContext.request.contextPath}/member/note/list">
                <div><i class="layui-icon">&#xe60a;</i></div>
                <div>我的笔记</div>
            </a>
        </div>
        <div class="layui-col-xs4 layui-col-sm3 layui-col-md3 horizontal-vertical-middle personal-center-item">
            <a href="${pageContext.request.contextPath}/member/collection/list">
                <div><i class="layui-icon">&#xe624;</i></div>
                <div>我的收藏</div>
            </a>
        </div>
        <div class="layui-col-xs4 layui-col-sm3 layui-col-md3 horizontal-vertical-middle personal-center-item">
            <a href="${pageContext.request.contextPath}/login/logout" class="item-red-bg">
                <div><i class="fa fa-sign-out" aria-hidden="true"></i></div>
                <div>注销</div>
            </a>
        </div>
    </div>


</div>


<jsp:include page="../base/footer.jsp"/>

</body>
</html>