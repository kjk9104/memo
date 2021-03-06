<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="d-flex justify-content-center">
	<div class="w-50">
	 <h1>글 목록</h1>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>작성날짜</th>
					<th>수정날짜</th>
				</tr>
			</thead>
			<c:forEach var="post" items="${postList}" varStatus="status">
				<tbody>
					<tr>
						<td>${post.id}</td>
						<td><a href="/post/post_detail_view?postId=${post.id}">${post.subject}</a></td>
						<fmt:formatDate var="createdAt" value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
						<fmt:formatDate var="updatedAt" value="${post.updatedAt}" pattern="yyyy-MM-dd HH:mm"/>
						<td>${createdAt}</td>
						<td>${updatedAt}</td>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		
		<div class="float-right">
			<a class="btn btn-primary" href="/post/post_create_view">글쓰기</a>
		</div>
	</div>
</div>

	