<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="signSection d-flex justify-content-center align-items-center">
	<div>
		<form id="signUpForm" method="post" action="/user/sign_up">
			<table class="table border border-2">
				<tbody>
					<tr>
						<td class="bg-secondary text-light">아이디</td>
						<td><input name="loginId"> <button id="chkBtn" type="button" class="bg-success text-light rounded border border-white">중복확인</button>
						<div id="idCheckLength" class="small text-danger d-none">ID을 4자 이상 입력하세요</div>
						<div id="idCheckduplicated" class="small text-danger d-none">미이 사용중인 아이디 입니다.</div>
						<div id="idCheckOk" class="small text-success d-none">사용 가능한 아이디 입니다.</div></td>
					</tr>
					
					<tr>
						<td class="bg-secondary text-light">비밀번호</td>
						<td><input type="password"id="password" name="password"></td>
					</tr>
					<tr>
						<td class="bg-secondary text-light">비밀번호 확인</td>
						<td><input type="password" id="confirmPassword"></td>
					</tr>
					<tr>
						<td class="bg-secondary text-light">이름</td>
						<td><input name="name"></td>
					</tr>
					<tr>
						<td class="bg-secondary text-light">이메일 주소</td>
						<td><input name="email"></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="bg-primary text-light rounded border border-white" value="회원가입">
		</form>
	</div>
</div>

<script>
$(document).ready(function(){
	$('#chkBtn').on('click', function(){
		let loginId= $('input[name=loginId]').val().trim();
		
		// 경고 문구 안보이게 초기화
		$('#idCheckLength').addClass('d-none');
		$('#idCheckduplicated').addClass('d-none');
		$('#idCheckOk').addClass('d-none');
		
		if(loginId.length < 4){
			$('#idCheckLength').removeClass('d-none');
			return;
		}
		$.ajax({
			url : "/user/is_duplicated_id"
			,data : {"loginId" : loginId}
			,success : function(data){
				if(data.result == true){
					// 중복인 경우
					$('#idCheckduplicated').removeClass('d-none');
				} else if (data.result == false) {
					// 중복이 아닌 경우 => 사용 가능한 아이디
					$('#idCheckOk').removeClass('d-none');
				} else {
					//에러
					alert("중복 체크에 실패 했습니다.");
				}
			}
			, error :  function(e) {
				alert("아이디 중복체크에 실패했습니다.");
			}
		});
	});
	
// 	회원 가입
	$('#signUpForm').on('submit', function(e) {
	
		
		e.preventDefault(); // submit 중단 시킴
		
		
		//validation
		
		let loginId = $('input[name=loginId]').val().trim();
		if(loginId == ""){
			alert("아이디를 입력하세요");
			return false;
		}

		let password = $('#password').val();
		let confirmPassword = $('#confirmPassword').val();
		
		if(password == "" || confirmPassword == ""){
			alert("비밀번호를 입력하세요");
			return false;
		}
		
		console.log("비밀번호"+password);
		console.log("비밀번호 확인"+confirmPassword);
		if(password != confirmPassword){
			// 텍스트의 값을 초기화한다.
			$('#password').val("");
			$('#confirmPassword').val("");
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		
		let name = $('input[name=name]').val().trim();
		if(name == ""){
			alert("이름을 입력하세요.");
			return false;
		}
		
		let email = $('input[name=email]').val().trim();
		if(email == ""){
			alert("email을 입력하세요.");
			return false;
		}
		// 아이디 검증 되었는지 확인
		// idCheckOk d-none이 있으면 성공이 아님
		if($('#idCheckOk').hasClass('d-none')) {
			alert("아이디 중복확인을 해주세요.");
			return false;
		}
		
		// 서버에 전송 
		
		// 1. form submit
		// e.preventDefalut()로 멈춰놓은 서브밋을 동작시키기
// 		$(this)[0].submit();
		
		// 2.ajax
		let url = $(this).attr("action"); // form태그에 있는 action값을 가져옴
		let params = $(this).serialize(); // form태그에 들어있는 name 속성 값들을 한번에 가져옴
		console.log(params);
		
		$.post(url, params)
		.done(function(data) {
			if(data.result == "success") {
				alert("회원가입을 환영합니다. 로그인을 해주세요");
				location.href = "/user/sign_in_view";
			} else {
				alert("회원가입에 실패했습니다. 다시 시도해 주세요");
			}
		});


	});
});
</script>