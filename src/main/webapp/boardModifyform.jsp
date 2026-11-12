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
String viewNum = request.getParameter("bnum");//유저가 수정하려는 글 번호확인

String sql2="SELECT * FROM board WHERE bnum=?";

String driverName="com.mysql.jdbc.Driver";
String url= "jdbc:mysql://localhost:3306/boardtest";
String username="root";
String password="12345";

Connection conn =null;
PreparedStatement pstmt = null;
ResultSet rs = null;
boardDto bDto = null;

try{
	  Class.forName(driverName);
	  conn = DriverManager.getConnection(url,username,password);
	  	  
	  pstmt = conn.prepareStatement(sql2);
	  pstmt.setString(1, viewNum);
	  rs = pstmt.executeQuery(); 
	 
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
  <h2> 글 내용수정하기</h2>
  <hr>
  <form action="boardModifyOk.jsp">
  <input type="hidden" name="bnum" value="${boardDto.bnum}">
  번호: ${boardDto.bnum}<br><br>
  작성자: ${boardDto.bwriter}<br><br>
  제목: <input type="text" name="btitle" value="${boardDto.btitle}" size="50"><br><br>
  내용: <textarea rows= "10" cols="50" name="bcontent" value="${boardDto.bcontent}"></textarea><br><br>
  <input type="submit" name="수정완료">
  <!-- 하이퍼링크 버튼 -->
  <!-- <input type="button" name="취소" onclick="location.href='boardList.jsp'">-->
  <input type="button" name="취소" onclick="history.go(-1)">
  <!-- 뒤로가기 버튼 -->
  </form>
  
</body>
</html>