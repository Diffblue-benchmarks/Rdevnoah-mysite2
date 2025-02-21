<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="${pageContext.servletContext.contextPath}/assets/css/board.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">
		<c:import url='/WEB-INF/views/includes/header.jsp' />
		<div id="content">
			<div id="board" class="board-form">
				<table class="tbl-ex">
					<tr>
						<th colspan="2">글보기</th>
					</tr>
					<tr>
						<td class="label">제목</td>
						<td>${board.title }</td>
					</tr>
					<tr>
						<td class="label">내용</td>
						<td>
							<div class="view-content">
								${fn:replace(board.contents, pageScope.newline, "<br>") }
							</div>
						</td>
					</tr>
				</table>
				<div class="bottom"> <!-- board.userNo와 session의 userNo가 같으면 글수정 아니면 답글달기 -->
				
					<a href="${pageContext.servletContext.contextPath }/board">글목록</a>
					<c:choose>
						<c:when test="${board.userNo == authUser.no}">
							<a href="${pageContext.servletContext.contextPath }/board/modify?no=${board.no }">글수정</a>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.servletContext.contextPath }/board/reply?no=${board.no }">답글달기</a>
						</c:otherwise>
					</c:choose>
				
				</div>
			</div>
		</div>
		<c:import url='/WEB-INF/views/includes/navigation.jsp'>
			<c:param name="menu" value="board" />
		</c:import>
		<c:import url='/WEB-INF/views/includes/footer.jsp' />
	</div>
</body>
</html>