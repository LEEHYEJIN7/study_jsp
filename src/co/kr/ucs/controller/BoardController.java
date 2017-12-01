package co.kr.ucs.controller;

import java.io.IOException;
import java.sql.SQLTimeoutException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.kr.ucs.bean.BoardBean;
import co.kr.ucs.service.BoardService;

public class BoardController extends HttpServlet{
	private static final long serialVersionUID = 1L;


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String uri=req.getRequestURI();
		String title=req.getParameter("title");
		String content=req.getParameter("content");
		
		HttpSession session = req.getSession(true);
		String userId=(String)session.getAttribute("user_id");
		
		BoardService service=new BoardService();
		String msg="";
		String view="";
		RequestDispatcher dis=null;
		
		// 글 작성
		if(uri.indexOf("/board/Write") > -1) {
			if(userId==null) {
				msg="로그인 해주세요";
				view="/jsp/login/signIn.jsp";
				dis=req.getRequestDispatcher(view);
			}else {
				int check;
				try {
					check = service.insertText(title, userId, content);
					
					if(check>0) {
						msg="글이 작성되었습니다.";
						view="/board/boardList";
						dis=req.getRequestDispatcher(view);
					}
				} catch (SQLTimeoutException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		}else if(uri.indexOf("/board/boardRead")>-1) {	// 글조회
			int seq=Integer.parseInt(req.getParameter("seq"));
			List<BoardBean> list;
			try {
				list = service.selectContents(seq);
				
				if(list!=null) {
					BoardBean bb=new BoardBean();
					bb=list.get(0);
					req.setAttribute("boardtext", bb);
					
					view="/jsp/board/boardRead.jsp";
					dis=req.getRequestDispatcher(view);
				}
			} catch (SQLTimeoutException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else if(uri.indexOf("/board/boardList")>-1) {	// 목록 조회			
			String pageNumber=req.getParameter("pageNumber");
			String search=req.getParameter("search");
			String searchInput=req.getParameter("searchInput");
			
			if(pageNumber==null) pageNumber="1";	
			int currentPage=Integer.parseInt(pageNumber);
			
			int pageBlock=10; // 하단에 보여질 페이지 수 (1~10)
			int boardSize=10; // 페이지에 보여지는 게시물 수 (10개)
			int startRow=(currentPage-1)*boardSize+1;
			int endRow=currentPage*boardSize;	
			
			List<BoardBean> list;
			try {
				list = service.selectBoardList(startRow, endRow, search, searchInput);
				
				int count=service.countBoard();
				System.out.println("list size + " + list.size());
				req.setAttribute("currentPage", currentPage);
				req.setAttribute("pageBlock", pageBlock);
				req.setAttribute("boardSize", boardSize);
				req.setAttribute("list", list);
				req.setAttribute("count", count);
				
				view="/jsp/board/boardList.jsp";
				dis=req.getRequestDispatcher(view);
			} catch (SQLTimeoutException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		System.out.println(msg);
		req.setAttribute("msg", msg);
		dis.forward(req, resp);
	}
}
