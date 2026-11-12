<%@page import="java.util.ArrayList"%>
<%@page import="board.boardDto"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 목록</title>
</head>
<body>

<%

  String sql="SELECT * FROM board ORDER BY bnum DESC";

  String driverName="com.mysql.jdbc.Driver";
  String url= "jdbc:mysql://localhost:3306/boardtest";
  String username="root";
  String password="12345";

  Connection conn =null;
  PreparedStatement pstmt = null;
  //DB로부터 반환하는 레코드 게시글을 받는 그릇역할 
  ResultSet rs = null;
  ArrayList<boardDto>boardList =new ArrayList<boardDto>();
  
  try{
	  Class.forName(driverName);
	  conn = DriverManager.getConnection(url,username,password);
	  //DB와 JSP 서버간의 connection 연결통로 생성
	  pstmt = conn.prepareStatement(sql);
	  //만들어진 커넥션을 통해서 sql문을 실행시키기 위한 단계 쿼리->셀렉트문
	  rs = pstmt.executeQuery(); 	
	  //rs그릇에 다음 뺄값이 있을때까지 반복하기
	  while(rs.next()){
		  int bnum = rs.getInt("bnum");
		  String btitle = rs.getString("btitle");
		  String bcontent = rs.getString("bcontent");
		  String bwriter = rs.getString("bwriter");
		  int bhit = rs.getInt("bhit");
		  String bdate = rs.getString("bdate");
		  //보드클래스를 그릇으로 받아주기 -> bDto
		  boardDto bDto = new boardDto(bnum, btitle,bcontent,bwriter,bhit,bdate);
	      boardList.add(bDto);
	    
	  }
	      //출력하는애가 가져가도록 무인택배함에 넣어두는 개념
	      request.setAttribute("boardList", boardList);
	  
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
  	  e.printStackTrace();
	  }
}
  //JSTL라이브러리 사용하여 반복문 실행 
%>
    <table border="1">
    <thead>
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>조회수</th>
        <th>작성일</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="bDto" items="${boardList}">
    <tr>
         <td>${bDto.bnum}</td>
         <td>
         <a href="boardView.jsp?bnum=${bDto.bnum}">
         <c:choose>
            <c:when test="${fn:length(bDto.btitle)>20}">
                     ${fn:substring (bDto.btitle,0,20)}...
            </c:when>
            <c:otherwise>
                     ${bDto.btitle}
            </c:otherwise>
         </c:choose>
         </a>
         </td>
         <td>${bDto.bwriter}</td>
         <td>${bDto.bhit}</td>
         <td>
             ${fn:substring (bDto.bdate,0,10)}
         </td>
    </tr>
    </c:forEach>
    </tbody>
    </table>       
    <input type="button" value="글쓰기" onclick="location.href='boardwrite.jsp'">       
</body>
</html>