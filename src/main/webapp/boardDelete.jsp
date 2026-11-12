<%@page import="board.boardDto"%>
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String dbnum = request.getParameter("bnum");

String sql="DELETE FROM board WHERE bnum=?"; //DELETE는 *사용 안함

String driverName="com.mysql.jdbc.Driver";
String url= "jdbc:mysql://localhost:3306/boardtest";
String username="root";
String password="12345";

Connection conn =null;
PreparedStatement pstmt = null;
boardDto bDto = null;

try{
	  Class.forName(driverName);
	  conn = DriverManager.getConnection(url,username,password);
	  
	  pstmt = conn.prepareStatement(sql);
	  pstmt.setString(1,dbnum);
	  int result = pstmt.executeUpdate(); 
	 //쿼리는 셀렉트문, 업데이트문 사용->rs필요없음
	  if(result==1){
		  System.out.println ("글 삭제 성공!");
		  response.sendRedirect("boardList.jsp");
	      }else{
	    	  System.out.println("글 삭제 실패!");
	      }
	          	  
          }catch(Exception e){
	      e.printStackTrace();
          }finally{
	      try{
	    	    	  
	    	  if(pstmt != null){
			  pstmt.close();
	          }
		      if(conn !=null){
	          conn.close();
	      }
	      }catch(Exception e){
	      
	      }
          }
%>
 <h2>게시판 글 내용보기</h2>
	<hr>
	<p>번호: ${boardDto.bnum}</p>
	<p>조회수: ${boardDto.bhit}</p>
	<p>제목: ${boardDto.btitle}</p>
	<p>내용: ${boardDto.bcontent}</p>
	<p>작성자: ${boardDto.bwriter}</p>
	<p>작성일: ${boardDto.bdate}</p>
  <hr>
  <input type="button" value="글목록" onclick="location.href='boardList.jsp'">
 
  
</body>
</html>