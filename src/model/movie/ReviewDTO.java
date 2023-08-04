package model.movie;

public class ReviewDTO {
	private String movieCd;
	private String movieNm;
	private String memberId;
	private String memberNc;
	private String review;
	private String writeDt;

	public String getMovieCd() {
		return movieCd;
	}

	public void setMovieCd(String movieCd) {
		this.movieCd = movieCd;
	}

	public String getMovieNm() {
		return movieNm;
	}

	public void setMovieNm(String movieNm) {
		this.movieNm = movieNm;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberNc() {
		return memberNc;
	}

	public void setMemberNc(String memberNc) {
		this.memberNc = memberNc;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public String getWriteDt() {
		return writeDt;
	}

	public void setWriteDt(String writeDt) {
		this.writeDt = writeDt;
	}
}
