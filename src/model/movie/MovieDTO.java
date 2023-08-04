package model.movie;

import java.util.ArrayList;
import java.util.HashMap;

public class MovieDTO {
	private String movieCd = null; // 영화코드
	private String movieNm = null; // 제목
	private String showTm = null; // 상영시간
	private String openDt = null; // 개봉일
	private String nationNm = null; // 제작국가
	private String watchGradeNm = null; // 심의등급
	private HashMap<String, String> actor = null;
	private ArrayList<String> genre = null;
	private String poster = null;

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

	public String getShowTm() {
		return showTm;
	}

	public void setShowTm(String showTm) {
		this.showTm = showTm;
	}

	public String getOpenDt() {
		return openDt;
	}

	public void setOpenDt(String openDt) {
		this.openDt = openDt;
	}

	public String getNationNm() {
		return nationNm;
	}

	public void setNationNm(String nationNm) {
		this.nationNm = nationNm;
	}

	public String getWatchGradeNm() {
		return watchGradeNm;
	}

	public void setWatchGradeNm(String watchGradeNm) {
		this.watchGradeNm = watchGradeNm;
	}

	public HashMap<String, String> getActor() {
		return actor;
	}

	public void setActor(HashMap<String, String> actor) {
		this.actor = actor;
	}

	public ArrayList<String> getGenre() {
		return genre;
	}

	public void setGenre(ArrayList<String> genre) {
		this.genre = genre;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

}
