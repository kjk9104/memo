package com.memo.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

/**
 * 실제로 파일 업로드 하는 곳 (no mapping)
 * @author user
 *
 */
// 스프링 빈
@Component // controller, service, reposiroty
public class FileManagerSevice {
	public final static String FILE_UPLODE_PATH ="D:\\kyu\\Spring_project\\memo\\workspace\\images/";
	
	// input : MultipartFile, userLoginId
	// output : String path
	public String savsFile(String userLoginId, MultipartFile file) {
		// 파일명이 겹치지 않게 하기 위해 userLoginId, 현재시간을 경로에 붙여준다.
		// 파일 디렉토리 경로 예: kjk9104_16874828147854/sum.png
		String directoryName = userLoginId + "_" + System.currentTimeMillis() + "/";//kjk9104_16874828147854/
		// D:\\kyu\\Spring_project\\memo\\workspace\\images/kjk9104_16874828147854/
		String filePath = FILE_UPLODE_PATH + directoryName;
		
		// 디렉토리 만들기
		File directory = new File(filePath);
		if(directory.mkdir() == false) {
			return null;
		}
		
		// 파일 업로드: byte 단위로 업로드 한다.
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + file.getOriginalFilename());	// TODO 파일명을 영어로 만들게
			Files.write(path, bytes); //파일 업로드 
			
			// 이미지 업로드 성공시 Path를 리턴한다.(WebMvcConfig에서 매핑한 이미지 path)
			// 예) http://localhost/images/kjk9104_16874828147854/sum.png
			return "/images/" + directoryName + file.getOriginalFilename(); // TODO 파일명은 Path랑 일치하게
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	public void deleteFile(String imagePath) throws IOException {
		// imagePath = /images/test2_1658477109450/5124630.png
		// "D:\\kyu\\Spring_project\\memo\\workspace\\images/ "
		// 전체 경로와 imagePath간의 중복되는 /images/ 문자영을 제거한 후 실제 저장 경로를 찾는다.
		
		imagePath = imagePath.replace("/images/",""); // /test2_1658477109450/5124630.png
		Path path = Paths.get(FILE_UPLODE_PATH + imagePath);
		if (Files.exists(path)) { // 이미지 파일이 있으면 삭제
			Files.delete(path);
		}
		
		// 디렉토리(폴더) 삭제
		path = path.getParent();
		if(Files.exists(path)) { // 폴더가 있으면 삭제
			Files.delete(path);
		}
		
	}
}
