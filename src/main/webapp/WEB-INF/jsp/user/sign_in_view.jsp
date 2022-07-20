<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <div id="loginHeader"class="d-flex justify-content-center align-items-center"><h1>로그인</h1></div>
<div id="loginBox" class="d-flex justify-content-center">
	<form id="signIn" method="post" action="/user/sign_in">
	<div class="d-flex flex-column">
		<input id="loninId" name="loginId" class="form-control-lg" type="text" placeholder="ID">
		<input id="pasworrd" name="password" class="form-control-lg" type="password" placeholder="password">
		<input id="loginForm" class="btn test-light form-control-lg btn-primary" type="submit" value="로그인"/>
		<a class="btn form-control-lg btn-secondary" href="#" type="button">회원가입</a>
	</div>
	</form>
</div>

<script>
$(document).ready(function() {
	$('#signIn').on('submit', function(e) {
		e.preventDefault();
		
		
		// validation
		let loginId = $('input[name=loginId]').val().trim();
		if(loginId.length < 1){
			alert("아이디를 입력하세요");
			return false;
		}
		
		let password = $('input[name=password]').val().trim();
		if(password.length < 1){
			alert("비밀번호를 입력하세요");
			return false;
		}

		//AJAX 호출
		let url = $(this).attr('action'); // form태그에 있는 action 주소
		let params = $(this).serialize(); //form 태그에 있는 name 값들을 쿼리스트링으로 구성
		
		$.post(url, params)
		.done(function(data){
			if(data.result == "success"){
				location.href ="/post/post_list_view";
			}else {
				alert(data.errorMessage);
			}
		});
	});
})
</script>