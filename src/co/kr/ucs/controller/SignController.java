package co.kr.ucs.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.kr.ucs.service.SignService;

public class SignController extends HttpServlet{
	private static final long serialVersionUID = 1L;
    	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		req.setCharacterEncoding("UTF-8");
		
		String uri=req.getRequestURI();
		String process=req.getParameter("process");
		String userId=req.getParameter("userId");
		String userPw=req.getParameter("userPw");
		String userNm=req.getParameter("userNm");
		String email=req.getParameter("email");
		
		System.out.println("********* SignController" + userId + userPw);
		
		SignService service=new SignService();
		String msg="";
		String view="";
		RequestDispatcher dis=null;
		
		// 로그인
		if(uri.indexOf("/sign/signIn") > -1) {
			try {
				int check=service.signIn(userId,userPw);
				if(check>0) {
					System.out.println("로그인 성공");
					msg="로그인 성공하였습니다.";
					HttpSession session = req.getSession(true);
					session.setAttribute("user_id", userId);
					
					view="/board/boardList";
					dis=req.getRequestDispatcher(view);								
				}else {
					msg="아이디와 비밀번호를 확인해주세요.";
					view="/jsp/login/signIn.jsp";
					dis=req.getRequestDispatcher(view);
				}
			}catch(Exception e) {
				msg="에러 발생";
				e.printStackTrace();
			}
		}else if(uri.indexOf("/sign/signUp") > -1) {	// 회원가입
			System.out.println("***회원가입****");
			try {
				int check=service.idCheck(userId);
				if(check==0) {
					System.out.println("중복 아이디 업음");
					service.signUp(userId, userPw, userNm, email);
					
					view="/jsp/login/signIn.jsp";
					dis=req.getRequestDispatcher(view);
				}else {
					msg="아이디 중복.";				
					view="/jsp/login/signUp.jsp";
					dis=req.getRequestDispatcher(view);
				}
			}catch(Exception e) {
				msg="에러 발생";
				e.printStackTrace();
			}
		}
		
		dis.forward(req, resp);		
	}
	
}
