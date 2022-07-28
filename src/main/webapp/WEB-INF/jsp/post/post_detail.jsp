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
			<img alt="업로드" src="${post.imagePath}" width="100">
		</div>
		</c:if>
		<div class="d-flex justify-content-between">
				<button id="postDeleteBtn" type="button" class="btn btn-secondary" data-post-id="${post.id}">삭제</button>
			<div>
				<a href="http://localhost/post/post_list_view" id="postListBtn" class="btn btn-dark">목록으로</a>
				<button id="savaBtn" type="button" class="btn btn-primary" data-post-id="${post.id}">저장</button>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	// 모두 지우기
	$("#savaBtn").on('click', function(){
		// validation
		let subject = $('#subject').val();
		let content = $('#content').val();
		let file = $('#file').val();
		if(subject==""){
			alert("제목을 입력해주세요");
			return;
		}
		if(content==""){
			alert("내용을 입력해주세요");
			return;
		}
		
		if(file != ""){
			let ext = file.split(".").pop().toLowerCase(); // 파일경로에서 .으로 나누고 배열에 저장 후 마지막 문자열 가져오고 소문자로 변경
			if($.inArray(ext, ["gif","jpeg","jpg","png"]) == -1) {
				alert("gif, jpeg, jpg, png 파일만 업로드 할 수 있습니다.");
				$('#file').val(""); // 파일을 비운다.
				return;
			}
		}
		
		let postId = $(this).data("post-id");

		// 이미지를 보내야 하므로 form 객체를 구성한다.
		let formData = new FormData();
		formData.append("postId", postId);
		formData.append("subject", subject);
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]);
		
		// ajax
		$.ajax({
			// request
			type : "put"
			,url : "/post/update"
			,data : formData
			,enctype : "multipart/form-data"  // 파일 업로드 위한 필수 설정
			,processData: false // 파일 업로드 위한 필수 설정
			,contentType: false // 파일 업로드 위한 필수 설정
			// response
			,success : function(data){
				if(data.result == "success"){
					alert("수정 되었습니다.");
					location.reload(true); // 새로고침
				}
			}
			,error: function(e){
				alert("저장 실패");
			}
		});
		
	});
	
	$('#postDeleteBtn').on('click', function(){
		let postId = $(this).data('post-id');
		// alert(postId);
		
		$.ajax({
			type : "DELETE"
			,url : "/post/delete"
			,data : { "postId" : postId }
			,success : function(data){
				if(data.result == "success"){
					alert("삭제 되었습니다.")
					location.href = "/post/post_list_view";					
				}else{
					alert(data.errorMessage);
				}
			}
			,error :  function(e){
				alert("삭제 실패");
			}
			
		});
		
	});
		
	
});
</script>