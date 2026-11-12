package board;

public class boardDto {
	  //board테이블 필드와 일치하는 멤버변수 선언
      private int bnum;
      private String btitle;
      private String bcontent;
      private String bwriter;
      private int bhit;
      private String bdate;
      
	  public boardDto() {
		super();
		// TODO Auto-generated constructor stub
	  }
	  public boardDto(int bnum, String btitle, String bcontent, String bwriter, int bhit, String bdate) {
		super();
		this.bnum = bnum;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.bwriter = bwriter;
		this.bhit = bhit;
		this.bdate = bdate;
	  }
	  public int getBnum() {
		  return bnum;
	  }
	  public void setBnum(int bnum) {
		  this.bnum = bnum;
	  }
	  public String getBtitle() {
		  return btitle;
	  }
	  public void setBtitle(String btitle) {
		  this.btitle = btitle;
	  }
	  public String getBcontent() {
		  return bcontent;
	  }
	  public void setBcontent(String bcontent) {
		  this.bcontent = bcontent;
	  }
	  public String getBwriter() {
		  return bwriter;
	  }
	  public void setBwriter(String bwriter) {
		  this.bwriter = bwriter;
	  }
	  public int getBhit() {
		  return bhit;
	  }
	  public void setBhit(int bhit) {
		  this.bhit = bhit;
	  }
	  public String getBdate() {
		  return bdate;
	  }
	  public void setBdate(String bdate) {
		  this.bdate = bdate;
	  }


}
