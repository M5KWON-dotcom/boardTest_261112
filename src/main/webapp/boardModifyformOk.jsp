<%@page import="board.boardDto"%>
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정 완료</title>
</head>
<body>
<%

request.setCharacterEncoding("utf-8");

String viewNum = request.getParameter("bnum");
String modifytitle = request.getParameter("btitle");
String modifycontent = request.getParameter("bcontent");

String sql1="UPDATE board SET btitle=?, bcontent=? WHERE bnum=?";//조회수 증가 sql문
String sql2="SELECT * FROM board WHERE bnum=?";

String driverName="com.mysql.jdbc.Driver";
String url= "jdbc:mysql://localhost:3306/boardtest";
String username="root";
String password="12345";

Connection conn =null;
PreparedStatement pstmt1 = null;
PreparedStatement pstmt2 = null;
ResultSet rs = null;
boardDto bDto = null;

try{
	  Class.forName(driverName);
	  conn = DriverManager.getConnection(url,username,password);
	  
	  pstmt1 = conn.prepareStatement(sql1);
	  pstmt1.setString(1, modifytitle);
	  pstmt1.setString(2, modifycontent);
	  pstmt1.setString(3, viewNum);
	  pstmt1.executeUpdate(); 
	  
	  pstmt2 = conn.prepareStatement(sql2);
	  pstmt2.setString(1, viewNum);
	  rs = pstmt2.executeQuery(); 
	 
	  if(rs.next()){
		  int bnum = rs.getInt("bnum");
		  String btitle = rs.getString("btitle");
		  String bcontent = rs.getString("bcontent");
		  String bwriter = rs.getString("bwriter");
		  int bhit = rs.getInt("bhit");
		  String bdate = rs.getString("bdate");
		 
		  bDto = new boardDto(bnum, btitle,bcontent,bwriter,bhit,bdate);
	      	    
	      }else{
	    	  System.out.println("존재하지 않는 글입니다.");
	      }
	      request.setAttribute("boardDto", bDto);
	  
          }catch(Exception e){
	      e.printStackTrace();
          }finally{
	      try{
	    	  if(rs != null){
				  rs.close();
		      }
	    	  
	    	  if(pstmt1 != null){
			  pstmt1.close();
	      }
	    	  if(pstmt2 != null){
				  pstmt2.close();
		      }
		  if(conn !=null){
	          conn.close();
	      }
	      }catch(Exception e){
	      
	      }
          }

%>
  <h2> 게시판 글 내용보기</h2>
  <hr>
  <p>번호: ${boardDto.bnum}</p>
  <p>조회수: ${boardDto.bhit}</p>
  <p>제목: ${boardDto.btitle}</p>
  <p>내용: ${boardDto.bcontent}</p>
  <p>작성자: ${boardDto.bwriter}</p>
  <p>작성일: ${boardDto.bdate}</p>
  <hr>
  <input type="button" value="글목록" onclick="location.href='boardList.jsp'">
  <input type="button" value="글수정" onclick="location.href='boardModifyform.jsp?bnum=${boardDto.bnum}'">
  <input type="button" value="글삭제" onclick="location.href='boardDelete.jsp?bnum=${boardDto.bnum}'">
  
</body>
</html>