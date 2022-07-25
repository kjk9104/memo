<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="d-flex justify-content-center">
	<div class="w-50">
		<h1>글 삭제/수정</h1>
		<input id="subject" class="form-control" type="text" placeholder="제목을 입력해주세요" value="${post.subject}">
		<textarea id="content" class="form-control" placeholder="내용을 입력해주세요"rows="15">${post.content}</textarea>
		<div class="d-flex justify-content-end my-4">
			<input id="file" type="file" accept=".jpg,.png,.gif,.jpeg">
		</div>
		<!-- 이미지가 있는 경우에만 노출  -->
		<c:if test="${not empty post.imagePath}">
		<div class="image-area">
			<img alt="업로드" src="${post.imagePath}" width="400">
		</div>
		</c:if>
		<div class="d-flex justify-content-between">
				<button id="PostDeleteBtn" type="button" class="btn btn-secondary">삭제</button>
			<div>
				<a href="http://localhost/post/post_list_view" id="postListBtn" class="btn btn-dark">목록으로</a>
				<button id="savaBtn" type="button" class="btn btn-primary">저장</button>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	// 모두 지우기
	$("#clearBtn").on('click', function(){
		$('#subject').val("");
		$('#content').val("");
	});
});
</script>