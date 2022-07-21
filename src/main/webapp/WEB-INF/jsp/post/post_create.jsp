<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="w-50">
		<h1>글쓰기</h1>
		<input id="subject" class="form-control" type="text" placeholder="제목을 입력해주세요">
		<textarea id="content" class="form-control" placeholder="내용을 입력해주세요" rows="15"></textarea>
		<div class="d-flex justify-content-end my-4">
			<input id="file" type="file" accept=".jpg,.png,.gif,.jpeg">
		</div>
		<div class="d-flex justify-content-between">
			<button id="postListBtn" type="button" class="btn btn-dark">목록</button>
			<div>
				<button id="clearBtn" type="button" class="btn btn-secondary">모두지우기</button>
				<button id="savaBtn" type="button" class="btn btn-primary">저장</button>
			</div>
		</div>
	</div>
</div>




<script>
$(document).ready(function(){
	// 목록 버튼 클릭 => 글 목록 이동
	$("#postListBtn").on('click', function(){
		location.href = "/post/post_list_view";
	});
	// 모두 지우기
	$("#clearBtn").on('click', function(){
		$('#subject').val("");
		$('#content').val("");
	});
	// 글 내용 저장
	$('#savaBtn').on('click', function(){
		let subject = $('#subject').val();
		let content = $('#content').val();
		let file = $('#file').val();
		
		if(subject.length < 1){
			alert("제목을 입력하세요");
			return;
		}
		
		if(content == ""){
			alert("내용을 입력하세요");
			return;
		}
		
		// 이미지 확장자 검증 - 파일이 업로드 된 경우
		
		if(file != ""){
			let ext = file.split(".").pop().toLowerCase(); // 파일경로에서 .으로 나누고 배열에 저장 후 마지막 문자열 가져오고 소문자로 변경
			if($.inArray(ext, ["gif","jpeg","jpg","png"]) == -1) {
				alert("gif, jpeg, jpg, png 파일만 업로드 할 수 있습니다.");
				$('#file').val(""); // 파일을 비운다.
				return;
			}
		}
		
		// 폼태그를 자바스크립트에서 만든다.
		let formData = new FormData();
		formData.append("subject", subject); // <input type="" name="subject">
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]); // $('#file')[0]: 첫번째 input file 태그, files[0] : 업로드 된 첫번째 파일
		
		// AJAX form 데이터 전송
		$.ajax({
			type : "POST"
			, url : "/post/create"
			, data : formData
			, enctype: "multipart/form-data"	 // 파일 업로드 필수 설정
			, processData: false			// 데이터의 들어가는 것을 String으로 만들어 주는 것을 꺼줌, 파일 업로드 필수 설정
			, contentType: false			//	파일 업로드 필수 설정
			, success : function(data){
				if(data.result == "success"){
					alert("메모가 저장되었습니다.");
					location.href = "/post/post_list_view";
				} else {
					alert(data.errorMessage);
				}
			} 
			, error : function(e){
				alert("통신에 실패 했습니다.");
			}
		});
		
	});
});
</script>