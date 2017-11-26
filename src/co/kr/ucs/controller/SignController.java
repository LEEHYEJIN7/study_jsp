package co.kr.ucs.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.kr.ucs.bean.UserBean;

public class SignController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri=req.getRequestURI();
		
		BufferedReader br=new BufferedReader(new InputStreamReader(req.getInputStream()));
		String paramString="";
		if(br!=null) {
			paramString=br.readLine();
		}
		
		System.out.println("********* SignController" + paramString + uri);
	}
	
}
