package co.kr.ucs.bean;

import java.util.Date;

public class BoardBean {
	private int seq;
	private String title;
	private String contents;
	private String regId;
	private Date regDate;
	private String modId;
	private Date modDate;	
	
	public BoardBean() {
		super();
	}

	public BoardBean(int seq, String title, String contents, String regId, Date regDate, String modId,
			Date modDate) {
		super();
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.regId = regId;
		this.regDate = regDate;
		this.modId = modId;
		this.modDate = modDate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	public Date getModDate() {
		return modDate;
	}

	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}

	@Override
	public String toString() {
		return "BoardBean [seq=" + seq + ", title=" + title + ", contents=" + contents + ", regId=" + regId
				+ ", regDate=" + regDate + ", modId=" + modId + ", modDate=" + modDate + "]";
	}
	
}
