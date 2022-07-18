<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="signSection d-flex justify-content-center align-items-center">
	<div>
		<form action="">
			<table class="table border border-2">
				<tbody>
					<tr>
						<td class="bg-secondary text-light">아이디</td>
						<td><input name="id"> <button class="bg-success text-light rounded border border-white">중복확인</button></td>
					</tr>
					<tr>
						<td class="bg-secondary text-light">비밀번호</td>
						<td><input name="password"></td>
					</tr>
					<tr>
						<td class="bg-secondary text-light">비밀번호 확인</td>
						<td><input></td>
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
			<input class="bg-primary text-light rounded border border-white" type="submit" value="회원가입">
		</form>
	</div>
</div>